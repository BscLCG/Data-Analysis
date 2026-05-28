# Week 2.2: Exploratory Data Analysis and Linear Regression

This section covers the initial inspection of quantitative data distributions and the foundational mechanics of Simple Linear Regression using Ordinary Least Squares (OLS) estimation.

## Required and Complementary Readings
* [Wooldridge, J. M. (2018). *Introductory econometrics: A modern approach* (Seventh edition).](../../References/Jeffrey%20M.%20Wooldridge%20-%202018-%20Introductury%20Econometrics.pdf) Cengage Learning. (pp. 60–105)
* Angrist, J. D., & Pischke, J.-S. (2015). *Mastering ’metrics: The path from cause to effect*. Princeton University Press. (pp. 47–79)
* Nahhas, R. W. (2025). *Introduction to Regression Methods for Public Health Using R*. [Ch. 5](https://bookdown.org/rwnahhas/RMPH/)

## Detailed Reading: EDA and Linear Modelling

### Exploratory Data Analysis (EDA)
Before applying formal statistical models, researchers must understand their data's structure. EDA identifies missing values, locates outliers, and reveals baseline distributions without imposing rigid assumptions. 

EDA employs two main approaches:
1. **Non-graphical techniques**: Calculation of summary statistics. For single variables, this includes the mean, median, variance, standard deviation, and interquartile range. For bivariate relationships, researchers compute correlation coefficients (Pearson for linear relationships between continuous variables, Spearman for monotonic relationships with ranked data).
2. **Graphical techniques**: Visual representation of data. Histograms and box plots illustrate the central tendency and dispersion of single variables, while scatter plots visualize the direction and shape of relationships between two variables. 

### Simple Linear Regression
Simple Linear Regression estimates the relationship between a single independent variable ($x$) and a continuous dependent variable ($y$). The model fits a straight line through the data points governed by the equation:

$$ y = \beta_0 + \beta_1 x + u $$

Where:
- $\beta_0$ is the intercept (the expected value of $y$ when $x=0$).
- $\beta_1$ is the slope (the change in $y$ for a one-unit increase in $x$).
- $u$ represents the unobserved error term (all other factors affecting $y$).

### Ordinary Least Squares (OLS) Estimation
The standard procedure for estimating $\beta_0$ and $\beta_1$ is Ordinary Least Squares (OLS). OLS calculates the specific line that minimizes the sum of squared differences (residuals) between the observed values in the sample and the values predicted by the model.

The OLS estimator for the slope parameter is derived as the sample covariance between $x$ and $y$ divided by the sample variance of $x$:

$$ \hat{\beta}_1 = \frac{\sum_{i=1}^n (x_i - \bar{x})(y_i - \bar{y})}{\sum_{i=1}^n (x_i - \bar{x})^2} $$

Once the slope is estimated, the intercept is computed as:

$$ \hat{\beta}_0 = \bar{y} - \hat{\beta}_1 \bar{x} $$

### OLS Assumptions
For OLS to provide valid, unbiased estimators of the population parameters, certain statistical conditions must hold:
1. **Linearity in parameters**: The relationship between $x$ and $y$ must be linear.
2. **Random sampling**: The data must be a random sample from the population.
3. **No perfect collinearity**: Independent variables must not be perfectly correlated (relevant for multiple regression).
4. **Zero conditional mean**: The expected value of the error term $u$, conditional on $x$, must be zero ($E[u|x] = 0$).
5. **Homoscedasticity**: The variance of the error term must be constant across all values of $x$ ($Var(u|x) = \sigma^2$).

If these conditions are met, OLS produces the Best Linear Unbiased Estimator (BLUE). However, researchers must be careful not to conflate correlation with causation; an estimated $\beta_1 \neq 0$ implies a linear association, but causal inference requires rigorous research design to isolate the effect from confounding variables.

## Cross-References
* Return to the [Course Root](../../README.md)
* Previous topic: [Problem and Research Questions](../W2_1_Problem_and_Research_Questions/README.md)
* Next topic: [Literature Review](../W3_1_Literature_Review/README.md)

## References and Materials

### View (PDFs)
- [W2. EDA and linear regression.pdf](./W2.%20EDA%20and%20linear%20regression.pdf)
- [W2. Inference and statistical significance.pdf](./W2.%20Inference%20and%20statistical%20significance.pdf)

### Download (Originals & Scripts)
- [W2. EDA and linear regression.pptx](./W2.%20EDA%20and%20linear%20regression.pptx)
- [W2. Inference and statistical significance.pptx](./W2.%20Inference%20and%20statistical%20significance.pptx)
