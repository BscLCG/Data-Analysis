# Week 13: Causal Mediation Analysis

## Overview

This week focuses on Multiple Mediation Analysis using the R programming language, specifically handling scenarios where the independent variable (X), mediators (M), and dependent variable (Y) are all binary or ordered categorical variables.

## Key Concepts

- **Multiple Mediation:** Evaluating the process through which an independent variable influences a dependent variable via multiple intervening mechanisms (mediators) simultaneously.
- **Structural Equation Modeling (SEM):** Utilizing the `lavaan` package in R to construct path models.
- **Endogenous Categorical Variables:** Handling binary outcomes using Diagonally Weighted Least Squares (DWLS) and logit/probit link functions within SEM.
- **Indirect and Total Effects:** Calculating specific indirect pathways ($a \times b$) and combining them with direct effects to estimate the total effect.

## Relevant Points

- **Data Transformation:** The code demonstrates how to recode continuous variables into dichotomous categories and dummy code ordinal covariates for modeling.
- **Simulation:** A practical exercise is provided to simulate mediators based on probabilities derived from logistic functions.

## Detailed Reading: Causal Mediation Analysis in R

In quantitative research, determining that an independent variable ($X$) affects a dependent variable ($Y$) is often insufficient. Researchers need to understand the mechanism through which that effect occurs. A mediating variable ($M$) represents that mechanism. When researchers introduce a mediator into their model, they divide the total effect of $X$ on $Y$ into two parts: the direct effect of $X$ on $Y$, and the indirect effect of $X$ on $Y$ transmitted through $M$.

While basic mediation involves one mediator, real-world social phenomena usually involve multiple mechanisms operating simultaneously. To analyze multiple mediators, researchers use Structural Equation Modeling (SEM). SEM allows researchers to construct path models that estimate all relationships (from $X$ to all $M$, and from all $M$ to $Y$) concurrently, rather than running multiple isolated regression models.

In this course, the practical application uses the `lavaan` package in R. The provided code demonstrates a complex scenario: analyzing multiple mediators when the independent variable, the mediators, and the dependent variable are all binary. 

Standard Ordinary Least Squares (OLS) estimation fails when dealing with endogenous categorical variables (mediators and dependent variables that are discrete). To solve this, `lavaan` requires researchers to explicitly define these variables as "ordered." Once defined as ordered, `lavaan` automatically switches the estimator from Maximum Likelihood (ML) to Diagonally Weighted Least Squares (DWLS). DWLS uses polychoric/tetrachoric correlations to estimate the underlying continuous distribution of the binary variables, ensuring mathematically sound parameter estimates.

The analysis process follows a strict sequence. First, the researcher transforms the data. The script uses dummy coding for covariates (like rank) and dichotomizes continuous variables (like GRE scores) using `ifelse` commands. The code then uses logistic probabilities to simulate three new binary mediators (e.g., essay pass, interview pass, recommendation pass) based on the independent variable (high vs. low GRE).

Second, the researcher defines the model syntax. In `lavaan`, the tilde (`~`) defines a regression path. The researcher specifies the paths from $X$ to each mediator ($M_1, M_2, M_3$), assigning labels to these coefficients ($a_1, a_2, a_3$). The researcher then specifies the paths from each mediator to $Y$ ($b_1, b_2, b_3$) and the direct path from $X$ to $Y$ ($c'$), alongside necessary covariates. 

Third, the researcher defines the specific indirect effects. The specific indirect effect for any single mediator is the product of its paths ($a \times b$). The `lavaan` syntax uses the `:=` operator to calculate these new parameters. The total indirect effect is the sum of all specific indirect effects ($a_1b_1 + a_2b_2 + a_3b_3$). Finally, the total effect is the sum of the direct effect and the total indirect effect ($c' + \text{Total Indirect}$).

By running this model, researchers can identify exactly which mechanism drives the outcome. For instance, the independent variable might have no direct effect on $Y$, but a strong, statistically significant indirect effect through $M_2$. This level of granularity is essential for designing targeted policy interventions or understanding complex theoretical frameworks established in the [Use of Theory](../W4_Use_of_theory/README.md) modules.

## References and Materials

- [W13.Mediation.R](./W13.Mediation.R)
