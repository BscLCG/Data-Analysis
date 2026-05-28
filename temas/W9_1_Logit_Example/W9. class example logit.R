# ---
# Title: Logistic Regression Analysis (Binomial Model)
# Author: Luis Carlos Guevara
# Date: 2026-04-29
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
names(dt)
names(dt)[names(dt) == "gre"]
names(dt)[2] <- "puntaje_ICFES"
class(dt$rank)
table(dt$rank)

dt$rank_cat <- NA

dt$rank_cat[dt$rank == 1] <- "rango_1"
dt$rank_cat[dt$rank == 2] <- "rango_2"
dt$rank_cat[dt$rank == 3] <- "rango_3"
dt$rank_cat[dt$rank == 4] <- "rango_4"

dt$rank_ord <- factor(dt$rank_cat, 
                      levels = c("rango_1", "rango_2", "rango_3", "rango_4"), 
                      ordered = TRUE)

# ==========================================
# Exploratory Data Analysis (EDA)
# ==========================================
# Perform Exploratory Data Analysis (EDA) using cross-tabulations and sample statistics.
summary(dt)
# sapply(dt, sd)
head(dt)
sapply(dt[c("puntaje_ICFES","gpa")], sd)


# Generate a cross-tabulation between the dependent variable (admit) and the university rank.
xtabs(~admit + rank_ord, data = dt)
xtabs(~admit + gpa, data = dt)
hist(dt$puntaje_ICFES)
hist(dt$gpa)

hist(dt$puntaje_ICFES[dt$admit == 1])
hist(dt$puntaje_ICFES[dt$admit == 0])


col1 <- rgb(0, 0, 1, 0.5) # Blue
col2 <- rgb(1, 0, 0, 0.5) # Red


hist(dt$puntaje_ICFES, 
     col = col1, 
     main = "Distribución Comparativa de Puntajes ICFES", 
     xlab = "Puntaje", 
     ylab = "Frecuencia",
     xlim = c(200, 500)) 

# Format the binary response variable 'admit' into a factor with descriptive labels (0 as "No admitido", 1 as "Admitido").
dt <- dt %>%
  mutate(admit = factor(admit, levels = c(0, 1), labels = c("No admitido", "Admitido")))

# Create a boxplot to visualize the distribution of GRE scores grouped by admission status.
ggplot(dt, aes(x = admit, y = gpa, fill = admit)) +
  geom_boxplot() +
  scale_fill_manual(values = c("steelblue", "red")) +
  labs(title = "Distribución de puntajes gpa por admisión",
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


# Estimate the binomial logit model using the Generalized Linear Model (glm) function with a logistic link.
logit <- glm(admit ~  puntaje_ICFES+ gpa + rank_ord, data = dt, family = "binomial")

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

# 3. Absence of Strongly Influential Outliers
# We can use Cook's Distance to check for extreme outliers that might disproportionately influence the model fit.
# Points significantly higher than the rest (often > 4/n) warrant further investigation.
plot(logit, which = 4, id.n = 3)

# ==========================================
# Predictions and Visualizations
# ==========================================

# Calculate predicted probabilities of admission holding GRE and GPA at their mean values, across all 4 institution ranks.
n_dt <- with(dt, data.frame(puntaje_ICFES = mean(puntaje_ICFES), 
                            gpa = mean(gpa), 
                            rank_ord = 
                              factor(rank_cat, 
                                     levels = c("rango_1", "rango_2", "rango_3", "rango_4"), 
                                     ordered = TRUE)
                            ))
names(n_dt)[names(n_dt) == "puntaje.ICFES"] <- "puntaje ICFES"
n_dt$rankP <- predict(logit, newdata = n_dt, type = "response")
uniquedt <- n_dt[!duplicated(n_dt$rankP),]

# The logistic model not only allows us to estimate individual probabilities, but also to construct comparative profiles of admission.
# By keeping GPA constant and systematically varying GRE and Rank, we can identify concrete cases of admission probability.
n_dt2 <- with(dt, data.frame(puntaje_ICFES = rep(seq(from = 200, to = 800, length.out = 100),4), 
                             gpa = mean(gpa), 
                             rank_ord = factor(rank_cat, 
                                               levels = c("rango_1", "rango_2", "rango_3", "rango_4"), 
                                               ordered = TRUE)
))

names(n_dt2)
names(n_dt2)[names(n_dt2) == "puntaje.ICFES"] <- "puntaje ICFES"


# Predict the values on the link scale (log-odds) and compute the standard errors to build confidence intervals.
n_dt3 <- cbind(n_dt2, predict(logit, 
                              newdata = n_dt2, 
                              type = "link",
                              se = TRUE))

# Transform the predicted log-odds (fit) and the confidence limits back into probabilities using the plogis (logistic cumulative distribution) function.
n_dt3 <- within(n_dt3, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})

# Plot the predicted probability of being admitted given university prestige levels and GRE scores, visualizing the comparative profiles and their confidence bands.
ggplot(n_dt3, aes(x = puntaje_ICFES, y = PredictedProb)) +
  geom_ribbon(aes(ymin = LL, ymax = UL, fill = factor(rank_ord)), alpha = 0.2) +
  geom_line(aes(colour = factor(rank_ord)), size = 1) +
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
perfil_A <- data.frame(puntaje_ICFES = 800, gpa = 4.0, rank_ord = factor("rango_4",levels = c("rango_1", "rango_2", "rango_3", "rango_4"), ordered = TRUE))
perfil_B <- data.frame(puntaje_ICFES = 600, gpa = 3.0, rank_ord = factor("rango_1",levels = c("rango_1", "rango_2", "rango_3", "rango_4"), ordered = TRUE))

# Predict the linear index (log-odds or eta) and standard errors for these specific student profiles.
pred_A <- predict(logit, newdata = perfil_A, type = "link", se.fit = TRUE)
pred_B <- predict(logit, newdata = perfil_B, type = "link", se.fit = TRUE)

# Convert the log-odds into bounded predicted admission probabilities.
prob_A <- plogis(pred_A$fit)
prob_B <- plogis(pred_B$fit)

# Calculate the standard errors on the probability scale to complete the profile evaluation.
se_A <- pred_A$se.fit * dlogis(pred_A$fit)
se_B <- pred_B$se.fit * dlogis(pred_B$fit)
