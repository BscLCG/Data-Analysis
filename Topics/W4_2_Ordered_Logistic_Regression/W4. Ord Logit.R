# ---
# Title: Ordinal Logistic Regression Analysis
# Author: Luis Carlos Guevara
# Date: 2026-04-22
# ---

# Load required libraries for data manipulation, visualization, and ordinal modeling
library(MASS)     # Required for polr() function (Proportional Odds Logistic Regression)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
library(reshape2)

# ==========================================
# Data Loading and Preparation
# ==========================================

# Load the UCLA ordinal dataset studying students' intent to apply to graduate school.
# The response variable 'apply' has three levels: "unlikely", "somewhat likely", and "very likely".
dat <- foreign::read.dta("https://stats.idre.ucla.edu/stat/data/ologit.dta")

# Inspect the structure of the dataset
summary(dat)

# Verify the ordinal nature of the dependent variable
# It is crucial that the response variable is an ordered factor.
str(dat$apply)

# Generate a cross-tabulation to explore the distribution of responses by parental education and school type.
xtabs(~apply + pared, data = dat)
xtabs(~apply + public, data = dat)

# ==========================================
# Model Fitting
# ==========================================

# Estimate the Proportional Odds Logistic Regression model using polr.
# We include 'pared' (parents' education), 'public' (public vs private), and 'gpa'.
m <- polr(apply ~ pared + public + gpa, data = dat, Hess = TRUE)

# View model summary: coefficients (log-odds), standard errors, and t-values.
# Note: polr does not provide p-values by default.
summary(m)

# --- Significance Testing ---
# Calculate p-values using the t-values and the normal distribution.
ctable <- coef(summary(m))
p <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2

ctable <- cbind(ctable, "p value" = p)
print(round(ctable, 3))

# --- Interpretation with Odds Ratios ---
# Transform log-odds to Odds Ratios (OR) and compute 95% confidence intervals.
ci <- confint(m)
OR <- exp(coef(m))
ci_exp <- exp(ci)

# Prepare data for Forest Plot visualization
df_plot <- tibble(
  variable = rownames(ci_exp),
  OR = OR,
  lower = ci_exp[, 1],
  upper = ci_exp[, 2],
  color = c("red", "steelblue", "steelblue1") # Custom colors for variables
)
df_plot$variable <- factor(df_plot$variable, levels = rev(df_plot$variable))

# ==========================================
# Diagnostic: Proportional Odds Assumption
# ==========================================
# A key assumption of the ordinal model is that the relationship between each pair of outcome groups 
# is the same (Parallel Slopes). We test this by comparing binary logits for different thresholds.

dat$y_gt1 <- as.numeric(dat$apply != "unlikely")      # unlikely vs (somewhat + very)
dat$y_gt2 <- as.numeric(dat$apply == "very likely")   # (unlikely + somewhat) vs very

m1 <- glm(y_gt1 ~ pared + public + gpa, data = dat, family = binomial)
m2 <- glm(y_gt2 ~ pared + public + gpa, data = dat, family = binomial)

# Compare coefficients visually: if the coefficients for m1 and m2 are similar, 
# the proportional odds assumption likely holds.
df1 <- tibble(modelo = "y > 1", variable = names(coef(m1)), OR = exp(coef(m1)))
df2 <- tibble(modelo = "y > 2", variable = names(coef(m2)), OR = exp(coef(m2)))
# (Full comparative Forest Plot logic would go here)

# ==========================================
# Predictions and Visualizations
# ==========================================

# Create a simulation grid to evaluate probabilities across GPA ranges and categories.
newdat <- data.frame(
  pared = rep(0:1, 200),
  public = rep(0:1, each = 200),
  gpa = rep(seq(from = 1.9, to = 4, length.out = 100), 4)
)

# Predict probabilities for each outcome level (unlikely, somewhat, very)
newdat <- cbind(newdat, predict(m, newdat, type = "probs"))

# Reshape data to long format for plotting
lnewdat <- melt(newdat, id.vars = c("pared", "public", "gpa"),
                variable.name = "Level", value.name = "Probability")

# Format levels for clear English visualization
lnewdat$Level <- factor(lnewdat$Level,
                        levels = c("unlikely", "somewhat likely", "very likely"),
                        labels = c("Unlikely", "Somewhat Likely", "Very Likely"))

# Plot the predicted probability curves
ggplot(lnewdat, aes(x = gpa, y = Probability, colour = Level)) +
  geom_line(size = 1.2) +
  facet_grid(pared ~ public, labeller = label_both) + # Row: Parents Edu | Col: Public School
  scale_color_manual(values = c("Unlikely" = "red", 
                                "Somewhat Likely" = "steelblue", 
                                "Very Likely" = "steelblue1")) +
  labs(
    x = "Grade Point Average (GPA)",
    y = "Predicted Probability",
    colour = "Intent Level",
    title = "Predicted Probabilities of Applying to Graduate School",
    subtitle = "By GPA, Parental Education, and Institution Type"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    strip.text = element_text(face = "bold", size = 12),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5)
  )

# ==========================================
# Forest Plot: Model Visualization
# ==========================================

ggplot(df_plot, aes(x = OR, y = variable)) +
  geom_point(aes(color = color), size = 3) +
  geom_errorbarh(aes(xmin = lower, xmax = upper, color = color), height = 0.2) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "gray50") +
  scale_x_log10() +
  scale_color_identity() +
  labs(
    x = "Odds Ratio (OR)",
    y = "Predictor Variables",
    title = "Forest Plot: Ordinal Logistic Regression"
  ) +
  theme_minimal(base_size = 13)
