# ---
# Title: Multiple Mediation Analysis (Binary X, Binary Mediators, Binary Y)
# Author: Luis Carlos Guevara (Adapted)
# ---

# Load required libraries
library(lavaan)
library(dplyr)
library(tidyr) # Helpful if you decide to add back the visualization plots

# ==========================================
# 1. Data Loading, Dichotomizing & Simulation
# ==========================================

dt <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

# A. Dummy coding for the covariates (Rank)
dt <- dt %>%
  mutate(
    rank2 = ifelse(rank == 2, 1, 0),
    rank3 = ifelse(rank == 3, 1, 0),
    rank4 = ifelse(rank == 4, 1, 0)
  )

# B. Make GRE Dichotomous (1 = High GRE [>= 600], 0 = Low GRE [< 600])
dt <- dt %>%
  mutate(
    gre_high = ifelse(gre >= 600, 1, 0)
  )

# C. Simulate the 3 new dichotomous mediators based on the binary gre_high
# We adjust the logit math. For example, in prob_essay: 
# If gre_high = 0 (Low GRE), prob is plogis(-1) = ~27% pass rate.
# If gre_high = 1 (High GRE), prob is plogis(-1 + 2) = plogis(1) = ~73% pass rate.
set.seed(123) 
dt <- dt %>%
  mutate(
    prob_essay = plogis(-1 + 2.0 * gre_high),
    essay_pass = rbinom(n(), size = 1, prob = prob_essay),
    
    prob_interview = plogis(-1.5 + 2.5 * gre_high),
    interview_pass = rbinom(n(), size = 1, prob = prob_interview),
    
    prob_rec = plogis(-0.5 + 1.5 * gre_high),
    rec_pass = rbinom(n(), size = 1, prob = prob_rec)
  )

# D. Define endogenous categorical variables as 'ordered' for lavaan.
# Note: We do NOT need to make 'gre_high' ordered because it is EXOGENOUS 
# (no arrows point to it). lavaan handles exogenous binary variables perfectly as 0/1 numeric.
dt$admit <- ordered(dt$admit)
dt$essay_pass <- ordered(dt$essay_pass)
dt$interview_pass <- ordered(dt$interview_pass)
dt$rec_pass <- ordered(dt$rec_pass)

# ==========================================
# 2. Defining the SEM Model (With gre_high)
# ==========================================

model_3_mediators_binaryX <- '
  # The X -> M pathways (Now using gre_high)
  essay_pass ~ a1 * gre_high
  interview_pass ~ a2 * gre_high
  rec_pass ~ a3 * gre_high

  # The M -> Y, X -> Y, and Covariate pathways pointing to Admit
  admit ~ cp * gre_high + b1 * essay_pass + b2 * interview_pass + b3 * rec_pass + gpa + rank2 + rank3 + rank4

  # Specific Indirect Effects
  ind_essay := a1 * b1
  ind_interview := a2 * b2
  ind_rec := a3 * b3

  # Total Effects
  total_indirect := ind_essay + ind_interview + ind_rec
  total_effect := cp + total_indirect
'

# ==========================================
# 3. Model Fitting & Results
# ==========================================

# Fit the model (lavaan automatically uses DWLS because endogenous variables are 'ordered')
fit <- sem(model = model_3_mediators_binaryX, data = dt)

# Print full summary
summary(fit, standardized = TRUE, fit.measures = TRUE, rsquare = TRUE)

# Extract just the indirect effects to compare
parameterEstimates(fit) %>% 
  filter(op == ":=") %>% 
  select(lhs, est, se, z, pvalue) %>%
  mutate(across(where(is.numeric), ~ round(., 4)))