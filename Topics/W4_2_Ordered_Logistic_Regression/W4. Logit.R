# ---
# Title: Logistic Regression Analysis (Binomial Model)
# Author: Luis Carlos Guevara
# Date: 2026-02-20
# ---

# Load required libraries for data manipulation, visualization, and diagnostic testing
library(aod)
library(ggplot2)
library(dplyr)
library(tidyr)
library(car) # Required for logistic regression assumption tests (VIF, Box-Tidwell)

# ==========================================
# Data Loading and Preparation
# ==========================================

# Load the UCLA binary dataset which studies how GRE scores, GPA, and undergraduate institution rank influence admission to postgraduate programmes.
# The response variable, admitted/not admitted, is binary.
dt <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

# ==========================================
# Exploratory Data Analysis (EDA)
# ==========================================
# Perform Exploratory Data Analysis (EDA) using cross-tabulations and sample statistics.
summary(dt)
sapply(dt, sd)

# Generate a cross-tabulation between the dependent variable (admit) and the university rank.
xtabs(~admit + rank, data = dt)

# Format the binary response variable 'admit' into a factor with descriptive labels (0 as "No admitido", 1 as "Admitido").
dt <- dt %>%
  mutate(admit = factor(admit, levels = c(0, 1), labels = c("No admitido", "Admitido")))

# Create a boxplot to visualize the distribution of GRE scores grouped by admission status.
ggplot(dt, aes(x = admit, y = gre, fill = admit)) +
  geom_boxplot() +
  scale_fill_manual(values = c("steelblue", "red")) +
  labs(title = "Distribución de puntajes GRE por admisión",
       x = "Admisión",
       y = "GRE") +
  theme_minimal() +
  theme(legend.position = "none")

# Create a boxplot to visualize the distribution of GPA scores grouped by admission status.
ggplot(dt, aes(x = admit, y = gpa, fill = admit)) +
  geom_boxplot() +
  scale_fill_manual(values = c("steelblue", "red")) +
  labs(title = "Distribución de GPA por admisión",
       x = "Admisión",
       y = "GPA") +
  theme_minimal() +
  theme(legend.position = "none")

# Ensure the institution 'rank' is treated as a categorical (ordinal/indicator) variable rather than a continuous numeric one.
dt$rank <- factor(dt$rank)

# ==========================================
# Model Fitting
# ==========================================

# Estimate the binomial logit model using the Generalized Linear Model (glm) function with a logistic link.
logit <- glm(admit ~ gre + gpa + rank, data = dt, family = "binomial")

# View the estimated coefficients in log-odds, standard errors, z-values, and p-values to evaluate if each coefficient is different from zero.
# Note: The estimated coefficients are in log-odds units and cannot be interpreted in the same way as OLS coefficients.
# For example, for each additional unit in the GRE score, the log-odds of admission increase by 0.002.
# For each additional unit in GPA, the log-odds of being admitted increase by 0.804.
summary(logit)

# To interpret the coefficients properly, one must compute odds ratios and evaluate predicted probabilities.
# We apply the exponential function to the estimated logit parameters to transform them from log-odds into Odds Ratios (OR), and attach their 95% confidence intervals.
exp(cbind(OR = coef(logit), confint(logit)))

# ==========================================
# Verification of Logistic Regression Assumptions
# ==========================================
# Logistic regression doesn't assume normality of residuals or homoscedasticity like OLS regression, but it has its own strict assumptions.

# 1. Absence of Multicollinearity
# Independent variables should not be highly correlated. We use the Variance Inflation Factor (VIF).
# A VIF value > 5 or 10 indicates problematic multicollinearity. Values near 1 are excellent.
vif(logit)

# 2. Linearity of the Logit (Box-Tidwell Test)
# Continuous independent variables (GRE, GPA) must have a linear relationship with the log-odds (logit) of the dependent variable.
# We test this by adding interaction terms between the continuous predictors and their natural logarithms.
# If the interaction term is significant (p < 0.05), the assumption is violated.
# Note: We only test the continuous variables (gre, gpa), not the categorical factor (rank).

dt$admit_num <- as.numeric(dt$admit) - 1
boxTidwell(admit_num ~ gre + gpa, ~ rank, data = dt)

# 3. Absence of Strongly Influential Outliers
# We can use Cook's Distance to check for extreme outliers that might disproportionately influence the model fit.
# Points significantly higher than the rest (often > 4/n) warrant further investigation.
plot(logit, which = 4, id.n = 3)

# ==========================================
# Predictions and Visualizations
# ==========================================

# Calculate predicted probabilities of admission holding GRE and GPA at their mean values, across all 4 institution ranks.
n_dt <- with(dt, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))
n_dt$rankP <- predict(logit, newdata = n_dt, type = "response")

# The logistic model not only allows us to estimate individual probabilities, but also to construct comparative profiles of admission.
# By keeping GPA constant and systematically varying GRE and Rank, we can identify concrete cases of admission probability.
n_dt2 <- with(dt, data.frame(gre = rep(seq(from = 200, to = 800, length.out = 100),
                                       4), gpa = mean(gpa), rank = factor(rep(1:4, each = 100))))

# Predict the values on the link scale (log-odds) and compute the standard errors to build confidence intervals.
n_dt3 <- cbind(n_dt2, predict(logit, newdata = n_dt2, type = "link",
                              se = TRUE))

# Transform the predicted log-odds (fit) and the confidence limits back into probabilities using the plogis (logistic cumulative distribution) function.
n_dt3 <- within(n_dt3, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})

# Plot the predicted probability of being admitted given university prestige levels and GRE scores, visualizing the comparative profiles and their confidence bands.
ggplot(n_dt3, aes(x = gre, y = PredictedProb)) +
  geom_ribbon(aes(ymin = LL, ymax = UL, fill = factor(rank)), alpha = 0.2) +
  geom_line(aes(colour = factor(rank)), size = 1) +
  scale_fill_manual(values = c("steelblue4", "steelblue2", "indianred2", "indianred4")) +
  scale_colour_manual(values = c("steelblue4", "steelblue2", "indianred2", "indianred4")) +
  labs(x = "GRE", y = "Probabilidad predicha", fill = "Rank", colour = "Rank") +
  theme_bw(base_size = 12) +
  theme(legend.position = "bottom",
        legend.title = element_text(face = "bold"),
        legend.background = element_rect(color = "gray80", fill = "gray95"),
        legend.key = element_rect(fill = "white"))

# ==========================================
# Specific Population Profiles
# ==========================================

# Create concrete population profiles (similar to María and Juan David) to evaluate specific cases of admission probability.
perfil_A <- data.frame(gre = 800, gpa = 4.0, rank = factor(4, levels = 1:4))
perfil_B <- data.frame(gre = 600, gpa = 3.0, rank = factor(1, levels = 1:4))

# Predict the linear index (log-odds or eta) and standard errors for these specific student profiles.
pred_A <- predict(logit, newdata = perfil_A, type = "link", se.fit = TRUE)
pred_B <- predict(logit, newdata = perfil_B, type = "link", se.fit = TRUE)

# Convert the log-odds into bounded predicted admission probabilities.
prob_A <- plogis(pred_A$fit)
prob_B <- plogis(pred_B$fit)

# Calculate the standard errors on the probability scale to complete the profile evaluation.
se_A <- pred_A$se.fit * dlogis(pred_A$fit)
se_B <- pred_B$se.fit * dlogis(pred_B$fit)