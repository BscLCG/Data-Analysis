# Week 3.2: Logistic Regression

This section covers the modelling of binary response variables using the logistic link function, addressing the limitations of the linear probability model and detailing the interpretation of log-odds and odds ratios.

## Required and Complementary Readings
* [Wooldridge, J. M. (2018). *Introductory econometrics: A modern approach* (Seventh edition).](../../References/Jeffrey%20M.%20Wooldridge%20-%202018-%20Introductury%20Econometrics.pdf) Cengage Learning. (pp. 524–536)
* Nahhas, R. W. (2025). *Introduction to Regression Methods for Public Health Using R*. [Ch. 6](https://bookdown.org/rwnahhas/RMPH/)

## Detailed Reading: Binomial Models and Logistic Regression

When the dependent variable is binary (e.g., admitted or not admitted, employed or unemployed), it takes only two mutually exclusive values: 0 and 1. The relevant statistical distribution is a binomial distribution with a single trial. The expected value of the variable, $\mu$, represents the probability of success $p(y=1)$.

### The Linear Probability Model (LPM) and its Limitations
The most direct approach is to use the identity function as a link, leading to the Linear Probability Model, which can be estimated using Ordinary Least Squares (OLS):

$$ p(y=1 | X) = \beta_0 + \beta_1 X_1 + \dots + \beta_k X_k $$

This approach has two main mechanical limitations:
1. **Unbounded predictions**: The identity function does not constrain predictions. The model can produce probabilities below 0 or above 1.
2. **Heteroskedasticity**: Because the outcome $y$ only takes the values 0 or 1, the residual is mechanically related to the covariates. The variance of a binomial variable depends on the mean: $Var(Y) = p(1-p)$. This violates the OLS homoskedasticity assumption, making standard errors biased unless corrected.

### The Logit Model
To ensure predicted probabilities always remain within the $[0,1]$ interval, non-linear models use alternative link functions. The logit model uses the logistic cumulative distribution function:

$$ p(y=1 | X) = \frac{1}{1 + e^{-(\beta_0 + \beta_1 X_1 + \dots + \beta_k X_k)}} $$

By transforming this equation, we move from probability to odds, and then to log-odds. The odds of an event is the probability of success divided by the probability of failure. The logit model specification is linear in the log-odds:

$$ \text{Log-odds} = \ln\left(\frac{p}{1-p}\right) = \beta_0 + \beta_1 X_1 + \dots + \beta_k X_k $$

This transformation converts a bounded variable (probability between 0 and 1) into an unbounded one (log-odds range from $-\infty$ to $+\infty$), simplifying statistical modelling. 

### Interpreting Coefficients: Odds Ratios and Marginal Effects
The estimated coefficients $\beta$ are in units of log-odds, which means they cannot be interpreted directly like OLS coefficients. 

#### Odds Ratios
To interpret a coefficient, researchers apply the exponential function to obtain the Odds Ratio (OR):

$$ \text{OR} = e^{\beta_k} $$

For example, if the estimated coefficient is $\beta = 0.1$, the odds ratio is $e^{0.1} \approx 1.105$. This means that a one-unit increase in the independent variable multiplies the initial odds by $1.105$, which translates to a 10.5% increase in the relative probability of the outcome. Note that this is a change in the *odds*, not the absolute *probability*, because the relationship between odds and probability is non-linear.

#### Marginal Effects and the 0.25 Rule
To estimate the maximum change in probability resulting from a one-unit change in the predictor, researchers use the derivative of the logistic function evaluated at its inflection point (where $p = 0.5$).

$$ \text{Max Change in Probability} \approx \beta_k \times [p(1-p)] \approx \beta_k \times 0.25 $$

This rule provides a quick approximation: dividing the coefficient by 4 yields the maximum percentage point change in the probability of success.

## Cross-References
* Return to the [Course Root](../../README.md)
* Previous topic: [Literature Review](../W3_1_Literature_Review/README.md)
* Next topic: [Use of Theory](../W4_1_Use_of_Theory/README.md)

## References and Materials

### View (PDFs)
- [W3. Logistic link model.pdf](./W3.%20Logistic%20link%20model.pdf)

### Download (Originals & Scripts)
- [W3. Logistic link model.pptx](./W3.%20Logistic%20link%20model.pptx)
- [W3. Linear regression.R](./W3.%20Linear%20regression.R)
