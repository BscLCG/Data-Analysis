# Week 13.1: Causal Mediation Analysis

> [!info] Overview
>
> This section explores multiple mediation analysis, focusing on scenarios where the independent variable, mediators, and dependent variable are categorical, requiring structural equation modeling (SEM) estimation.

## Required and Complementary Readings

* Facer, M., & Collins, S. (2014). Structural Equation Modeling with Categorical Variables.

## Detailed Reading: Analyzing Mechanisms with SEM

Determining that an independent variable ($X$) affects a dependent variable ($Y$) is often insufficient for robust empirical research. Researchers must identify the mechanism through which that effect occurs. A mediating variable ($M$) represents that exact mechanism. 

When researchers introduce a mediator into their model, they partition the total effect of $X$ on $Y$ into two components: 

1. The **direct effect** of $X$ on $Y$ ($c'$).
2. The **indirect effect** of $X$ on $Y$ transmitted through $M$ ($a \times b$).

### Multiple Mediation and Structural Equation Modeling
Because social phenomena rarely operate through a single mechanism, researchers often analyze multiple mediators simultaneously. To execute this, researchers use Structural Equation Modeling (SEM). SEM constructs path models that estimate all relationships concurrently (from $X$ to $M_1, M_2, M_3$, and from all $M$ to $Y$), preventing the omitted variable bias that occurs when running isolated regression models.

In this course, practical application utilizes the `lavaan` package in R. The specific analytical challenge occurs when $X$, $M$, and $Y$ are all binary or ordinal categorical variables. 

### Estimating Categorical Endogenous Variables
Standard Ordinary Least Squares (OLS) or Maximum Likelihood (ML) estimation fails when endogenous variables (mediators and outcomes) are discrete. In `lavaan`, the researcher must explicitly define these variables as "ordered." This triggers a shift from ML to the Diagonally Weighted Least Squares (DWLS) estimator. DWLS computes polychoric and tetrachoric correlations to map the underlying continuous distribution of the categorical variables, ensuring unbiased parameter estimates.

The syntax for path modeling explicitly defines direct and indirect pathways. The researcher specifies the pathways from $X$ to each mediator (labeled $a_1, a_2, a_3$), and the pathways from each mediator to $Y$ (labeled $b_1, b_2, b_3$). The specific indirect effect for any given mechanism is the mathematical product of its two paths ($a \times b$). The sum of all specific indirect effects constitutes the total indirect effect.

This level of granularity is essential. An independent variable may show zero direct effect on $Y$, but possess a strong, statistically significant indirect effect through a specific mediator ($M_2$). Identifying this pathway provides the empirical evidence required to validate complex [theoretical frameworks](../W4_1_Use_of_Theory/README.md).

> [!tip] Cross-References
>
> * Return to the [Course Root](../../README.md)
> * Previous topic: [Logit Example](../W9_1_Logit_Example/README.md)
> * Next topic: [Final Presentations](../W14_1_Presentations/README.md)

> [!note] References and Materials
>
> **View (PDFs)**
> _No PDF materials for this week._
>
> **Download (Originals & Scripts)**
> 
> - [W13.Mediation.R](./W13.Mediation.R)
