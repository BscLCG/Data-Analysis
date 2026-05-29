# Week 4.2: Ordered Logistic Regression

> [!info] Overview
>
> This section extends the logistic framework to model ordinal categorical dependent variables. It introduces the proportional odds model, threshold parameters, and the latent variable conceptualization of ordered categories.

## Required and Complementary Readings

* Nahhas, R. W. (2025). *Introduction to Regression Methods for Public Health Using R*. [Ch. 6](https://bookdown.org/rwnahhas/RMPH/)

## Detailed Reading: Modelling Ordinal Categories

When the dependent variable is categorical with more than two ordered categories (e.g., "Low", "Medium", "High"), binary logistic models are insufficient, and standard linear regression (OLS) ignores the discrete nature of the categories. Ordinal logistic regression addresses this by respecting the ordered structure without assuming equal intervals between categories.

### The Latent Variable Framework
The ordered logistic model assumes that the observed ordinal outcome $Y$ is a discrete realization of an underlying, unobserved continuous variable $Y^*$. The variable $Y^*$ is determined by a linear combination of predictors plus a random error term:

$$ Y^* = \beta_1 X_1 + \dots + \beta_k X_k + \epsilon $$

In the ordered logit model, the error term $\epsilon$ is assumed to follow a standard logistic distribution. The decision regarding which category $Y$ falls into depends on where the latent variable $Y^*$ lands relative to a series of estimated thresholds (or cut-points), denoted as $\mu_1, \mu_2, \dots, \mu_{m-1}$.

### The Proportional Odds Model
The standard formulation for ordinal regression is the Proportional Odds model, which specifies the cumulative probability that an observation falls into category $j$ or below:

$$ P(Y \leq j) = \frac{e^{\mu_j - (\beta_1 X_1 + \dots + \beta_k X_k)}}{1 + e^{\mu_j - (\beta_1 X_1 + \dots + \beta_k X_k)}} $$

By applying the natural logarithm to both sides of the ratio between $P(Y \leq j)$ and $P(Y > j)$, we obtain the linear specification of the log-odds:

$$ \text{Log-odds}(Y \leq j) = \ln\left(\frac{P(Y \leq j)}{P(Y > j)}\right) = \mu_j - (\beta_1 X_1 + \dots + \beta_k X_k) $$

The model estimates a specific intercept (cut-point $\mu_j$) for each transition between categories, but **estimates a single coefficient $\beta_k$ for each predictor across all thresholds**. 

### The Proportional Odds Assumption
A central constraint of this model is the Proportional Odds (or parallel-regression) assumption. It posits that the effect of a predictor $X$ is identical across all category splits. Graphically, an increase in $X$ shifts the cumulative distribution curve but does not change its shape or slope.

If the true slopes differ across cut-points, the single estimated $\beta$ becomes an average that fits poorly at the extremes of the ordinal scale. Researchers must formally test this assumption using tests such as the **Brant test**, which compares the coefficients from separate binary logit models estimated for each threshold.

If the assumption is violated, the researcher must decide whether to:

1. Re-categorize the variable (if theoretically justified).
2. Fit a multinomial logit model (which ignores ordinality).
3. Fit a partial proportional odds model, relaxing the assumption only for the specific variables that violate it.

> [!tip] Cross-References
>
> * Return to the [Course Root](../../README.md)
> * Previous topic: [Use of Theory](../W4_1_Use_of_Theory/README.md)
> * Next topic: [Mixed Methods](../W5_1_Mixed_Methods/README.md)

> [!note] References and Materials
>
> **View (PDFs)**
> 
> - [W4. OrderedLogistic model.pdf](./W4.%20OrderedLogistic%20model.pdf)
>
> **Download (Originals & Scripts)**
> 
> - [W4. OrderedLogistic model.pptx](./W4.%20OrderedLogistic%20model.pptx)
> - [W4. Logit.R](./W4.%20Logit.R)
