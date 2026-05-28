# ---
# Title: Linear Regression
# Author: Luis Carlos Guevara
# Date: 2026-02-20
# ---

# Load necessary libraries for data manipulation, visualization, and diagnostic testing
library(datasets)
library(ggplot2) 
library(lmtest) # Required for assumption verification tests (bptest, dwtest, resettest)
library(car)    # Required for multicollinearity test (vif)

# Load the built-in mtcars dataset and preview the first few rows
data(mtcars) 
head(mtcars)

# ==========================================
# Exploratory Data Analysis (EDA)
# ==========================================
# Perform an exploratory analysis of the data to understand the relationship 
# between the variables of interest.

# Generate summary statistics for the dataset
summary(mtcars) 

# Create a scatter plot of Weight vs. MPG to visually inspect their relationship
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() + 
  labs(title = "Scatter plot of Weight vs. MPG", 
       x = "Weight (1000 lbs)", 
       y = "Miles Per Gallon (MPG)")

# Calculate the Pearson correlation coefficient between weight and MPG
cor(mtcars[,"wt"], mtcars[,"mpg"])

# ==========================================
# Model Fitting
# ==========================================
# Now we fit a linear regression model between Y (gallons consumed per mile) and X (car weight):
# Y = B0 + B1 * X + e
# Here, B0 and B1 are the regression coefficients of the model, and 'e' represents independent random errors.
#
# Fitting a linear regression means deriving: Y_hat = b0 + b1 * X
# Here, Y_hat is a fitted prediction for the observed values. The difference (Y - Y_hat) is the prediction error, or residual.
# b0 and b1 are estimates for the regression coefficients. They are identified using the Ordinary Least Squares (OLS) method, which minimizes the sum of squared residuals: Sum(Y - Y_hat)^2.

# Fit the simple linear regression model 
modelo <- lm(mpg ~ wt, data = mtcars) 

# Display the summary of the model
# In the summary output, the intercept is b0 and the coefficient under the 'wt' column is b1 (the slope).
# The slope is estimated to be -5.34. The magnitude of this value doesn't inherently mean the effect of weight on performance is "high"; this magnitude is determined by the scales/units of the X and Y variables.
summary(modelo)

# Generate standard visual diagnostic plots 
# 1. Residuals vs Fitted: Checks for non-linear patterns.
# 2. Normal Q-Q: Checks if residuals are normally distributed.
# 3. Scale-Location: Checks the assumption of constant variance (homoscedasticity).
# 4. Residuals vs Leverage: Identifies influential observations/outliers.
par(mfrow = c(2, 2))
plot(modelo)

# ==========================================
# Verification of Linear Regression Assumptions
# ==========================================
# Beyond visual diagnostics, we use formal statistical tests to verify 
# the core assumptions of the simple linear regression model.

# 1. Normality of Residuals
# The Shapiro-Wilk test evaluates the null hypothesis that the residuals are normally distributed.
# A p-value > 0.05 indicates we cannot reject the null hypothesis (i.e., residuals are normally distributed).
shapiro.test(residuals(modelo))

# 2. Homoscedasticity (Constant Variance of Residuals)
# The Breusch-Pagan test evaluates the null hypothesis that the variance of the residuals is constant.
# A p-value > 0.05 indicates that the homoscedasticity assumption is met.
bptest(modelo)

# 3. Independence of Residuals
# The Durbin-Watson test checks for first-order autocorrelation in the residuals.
# A p-value > 0.05 indicates we cannot reject the null hypothesis of no true autocorrelation.
dwtest(modelo)

# 4. Linearity
# The RESET test checks for non-linear combinations of the fitted values. 
# A p-value > 0.05 suggests the linear specification is appropriate.
resettest(modelo, power = 2:3, type = "fitted")


# ==========================================
# Regression and Categorical Variables
# ==========================================

# Fit a model predicting transmission type (am) based on weight (wt)
modelo2 <- lm(am ~ wt, data = mtcars) 
summary(modelo2)

# Fit a model predicting MPG based on transmission type (am)
modelo3 <- lm(mpg ~ am, data = mtcars) 
summary(modelo3)

# Perform a t-test to formally compare MPG across the two transmission types
t.test(mpg ~ am, data = mtcars)


# ==========================================
# Regression and Uncertainty
# ==========================================

# Plot actual vs fitted values to visualize model accuracy
par(mfrow = c(1, 1)) # Reset plot layout to single plot
plot(mtcars$wt, mtcars$mpg, main = "Actual vs Fitted Values",
     xlab = "Weight", ylab = "Miles Per Gallon", pch = 19, col = "blue")
points(mtcars$wt, fitted(modelo), col = "red", pch = 19)
legend("topright", legend = c("Actual", "Fitted"), col = c("blue", "red"), pch = 19)

# Calculate Sum of Squared Residuals (SSR)
SRC <- sum((fitted(modelo) - mtcars$mpg)^2)
SRC

# Calculate Explained Sum of Squares (ESS)
SEC <- sum((fitted(modelo) - mean(mtcars$mpg))^2)
SEC

# Calculate Total Sum of Squares (TSS)
STC <- SRC + SEC
STC

# Calculate R-squared (Coefficient of Determination) manually
R2 <- SEC / STC
R2

# View the structure of the model summary object to see accessible metrics
str(summary(modelo))

# Let's consider 4 random samples. We use a for loop to perform an identical regression analysis on 4 randomly selected samples.
# Inside the loop, we implement the following steps for each iteration:
# - Step 1: Randomly select 10 different cars using R's sample function.
# - Step 2: Run the least squares regression only on the selected cars.
# - Step 3: Calculate a 95% confidence band for the true population regression line using the sample.

par(mfrow = c(2, 2)) # Set up a 2x2 grid for the 4 plots
for(i in 1:4){
  # Plot the full population
  plot(mpg ~ wt, data = mtcars,
       xlab = "Weight", ylab = "Miles Per Gallon",
       main = paste("Random Sample", i),
       ylim = c(min(mtcars$mpg), max(mtcars$mpg) + 0.3))
  
  # Add the true population regression line
  abline(modelo)
  
  if(i == 1){
    legend("topright", 
           pch = c(NA, NA, NA, 1, 16), 
           lty = c(1, 1, 2, NA, NA),
           col = c(1, 2, 2, 1, 2),
           legend = c("Population truth", "Sample estimate",
                      "Sample confidence band", 
                      "Population (unselected)", "Sampled"),
           cex = 0.7,
           bty = "n")
  }
  
  # Step 1: Randomly select 10 cars
  selected.cars <- sample(1:nrow(mtcars), 10)
  
  # Highlight the sampled points in red
  points(mtcars[selected.cars, "wt"], 
         mtcars[selected.cars, "mpg"], pch = 16, col = 2)
  
  # Step 2: Fit a regression line using only the sample
  model.sel <- lm(mpg ~ wt, data = mtcars[selected.cars, ])
  abline(model.sel, col = 2)
  
  # Step 3: Make a confidence band
  # Calculate the critical t-value for the width of the band
  ww <- qt(0.975, 10 - 2)
  
  # Generate plotting X values
  plot.x <- data.frame(wt = seq(1.513, 5.424, 0.1))
  
  # Predict values and standard errors (se.fit=T saves the SE of fitted values)
  plot.fit <- predict(model.sel, plot.x, 
                      level = 0.95, interval = "confidence", 
                      se.fit = TRUE)
  
  # Add connected lines for the upper and lower confidence bounds
  lines(plot.x$wt, plot.fit$fit[, 1] + ww * plot.fit$se.fit, 
        col = 2, lty = 2)
  lines(plot.x$wt, plot.fit$fit[, 1] - ww * plot.fit$se.fit, 
        col = 2, lty = 2)
}

# ==========================================
# Multiple Regression
# ==========================================

# Generate a synthetic dataset for public policies
set.seed(123)
n <- 1000
region <- paste("Region", 1:n)
education_expenditure <- runif(n, 5000, 15000)   # Education spending (in millions)
healthcare_expenditure <- runif(n, 2000, 10000)  # Healthcare spending (in millions)
poverty_rate <- runif(n, 5, 30)                  # Poverty rate (percentage)

# Calculate economic output based on true coefficients and random noise
economic_output <- 10000 + 0.5 * education_expenditure + 0.3 * healthcare_expenditure - 200 * poverty_rate + rnorm(n, 0, 5000) 

public_policies_data <- data.frame(region, education_expenditure, healthcare_expenditure, poverty_rate, economic_output)

# Fit a multiple regression model to evaluate the impact of these variables on economic output
modelo_mult <- lm(economic_output ~ education_expenditure + healthcare_expenditure + poverty_rate, data = public_policies_data)

# Summarize the multiple regression model
summary(modelo_mult)

# ==========================================
# Verification of Multiple Regression Assumptions
# ==========================================
# Just like with simple linear regression, we must verify the assumptions 
# for our multiple regression model. With multiple predictors, we also need 
# to check for multicollinearity.

# 1. Absence of Multicollinearity
# The Variance Inflation Factor (VIF) measures how much the variance of an estimated 
# regression coefficient increases when your predictors are correlated.
# VIF values > 5 or 10 indicate problematic multicollinearity. Values near 1 are ideal.
vif(modelo_mult)

# 2. Normality of Residuals
# The Shapiro-Wilk test evaluates if the residuals are normally distributed.
# Note: For very large datasets (n > 5000), shapiro.test might not work natively, but here n = 1000.
shapiro.test(residuals(modelo_mult))

# 3. Homoscedasticity (Constant Variance of Residuals)
# The Breusch-Pagan test checks if the variance of the residuals is constant.
bptest(modelo_mult)

# 4. Independence of Residuals
# The Durbin-Watson test checks for autocorrelation in the residuals.
dwtest(modelo_mult)

# 5. Linearity
# The RESET test checks for non-linear combinations of the fitted values.
resettest(modelo_mult, power = 2:3, type = "fitted")