# Week 3: Literature Review and Logistic Regression

## Overview

This week bridges qualitative research framing with advanced quantitative modeling. The first section details the process of conducting a systematic literature review to frame a research proposal, including searching, prioritizing, and mapping literature. The second section introduces binomial models for binary outcome variables, highlighting the limitations of the Linear Probability Model (LPM) and explaining the mathematical foundations and interpretation of Logit and Probit models.

## Key Concepts

- **Literature Review:** The systematic process of locating, evaluating, and summarizing studies to identify gaps and build a theoretical framework.
  - *Literature Maps:* Visual tools (hierarchical, flow-based, set-based) to organize existing research.
- **Binomial Models:** Statistical models where the outcome variable is strictly binary (e.g., 0 or 1, success or failure).
- **Linear Probability Model (LPM):** Uses OLS for binary outcomes but suffers from heteroscedasticity and predictions outside the $[0,1]$ range.
- **Logit and Probit Models:** Non-linear models using logistic and standard normal cumulative distribution functions (link functions) to bound predicted probabilities between 0 and 1.
- **Odds and Log-Odds:** The logistic function transforms bounded probabilities into unbounded log-odds, ensuring linear relationships with the predictors.
- **Odds Ratio (OR):** Exponentiated Logit coefficients that represent the multiplicative change in the odds of the outcome for a one-unit increase in the predictor.

## Relevant Points

- **Review Structure:** The organization of a literature review varies by design (qualitative studies explore inductively, while quantitative studies use the literature deductively to test hypotheses).
- **Non-Linear Transformations:** Since probabilities cannot exceed 1 or drop below 0, Logit models use the logistic function to model the *log-odds* instead of raw probabilities.
- **Interpretation of Logit Coefficients:** Logit coefficients cannot be interpreted as direct probability changes. They must be evaluated as odds ratios ($e^\beta$) or through marginal effects (e.g., using the "divide by 4" rule at the inflection point).

## Detailed Reading 1: Structuring a Literature Review

A literature review is the systematic process of locating, evaluating, and synthesizing previous research. The purpose is to identify what is already known about a topic and locate gaps that the new research will address. In academic projects, researchers do not start from zero; they build upon existing frameworks. 

The structure of the review depends on the chosen [research approach](../W1_Intro_and_research/README.md). In quantitative research, the literature review is extensive and occurs at the beginning of the study. Researchers use it deductively to justify the research problem and identify variables for testing. In qualitative research, the literature review is often brief and occurs at the beginning to justify the problem, but it allows the data to shape the findings inductively. In mixed methods, the review must support both approaches.

To organize the literature, researchers use visual tools called literature maps. A literature map presents a visual summary of the research conducted by others. Researchers typically use three structures for these maps:
1. Hierarchical structure: Presents a top-down organization of the literature, moving from broad categories to specific sub-topics.
2. Flowchart structure: Shows the progression of literature as a process or sequence of events.
3. Circle structure: Groups literature into overlapping thematic sets.

Once mapped, researchers structure the written review. A standard model for writing the review contains five components:
1. Introduction: Defines the central theme and explains the organization of the review.
2. Topic 1: Explores literature on the independent variable or central concept.
3. Topic 2: Explores literature on the dependent variable or outcome.
4. Topic 3: Explores literature that connects the independent and dependent variables.
5. Summary: Highlights the major deficiencies in the existing literature and explicitly connects them to the proposed study.

By following this structure, researchers ensure the literature review justifies the research question rather than simply listing previous articles.

## Detailed Reading 2: Binomial Models and Logistic Regression

In statistical analysis, the nature of the outcome variable dictates the appropriate model. When the dependent variable ($Y$) is continuous, researchers use [linear regression](../W2_EDA_and_research_questions/README.md). However, when the outcome variable is strictly binary (e.g., success/failure, voted/did not vote, approved/rejected), the assumptions of Ordinary Least Squares (OLS) fail. 

Applying OLS to a binary outcome creates a Linear Probability Model (LPM). The LPM attempts to predict the probability that $Y = 1$. The LPM suffers from two fatal structural flaws. First, it assumes homoscedasticity, but the variance of a binary variable depends on its probability, guaranteeing heteroscedasticity. Second, a straight line extends infinitely, meaning the LPM can predict probabilities greater than 1 or less than 0, which is mathematically impossible.

To solve this, researchers use binomial models: Logit and Probit. These models apply a non-linear link function to compress the predicted values into the $[0,1]$ range. The Logit model uses the cumulative logistic distribution, while the Probit model uses the standard normal cumulative distribution. Both produce an S-shaped (sigmoid) curve.

Because the Logit model bends the prediction line to keep it bounded, the relationship between the independent variable ($X$) and the probability of $Y=1$ is no longer linear. The effect of a one-unit change in $X$ is largest near the middle of the curve (probability = 0.5) and approaches zero near the tails (probability near 0 or 1). 

To regain linearity for estimation, the Logit model applies the logit transformation. Instead of modeling the raw probability $p$, it models the natural logarithm of the odds (log-odds). The odds represent the ratio of the probability of success to the probability of failure ($p / (1-p)$). The log-odds equation is linear: $\ln(\frac{p}{1-p}) = \beta_0 + \beta_1 X$.

Because the coefficients in a Logit model represent changes in log-odds, they cannot be interpreted as direct changes in probability. Researchers use two methods to interpret Logit results:
1. Odds Ratios (OR): By exponentiating the coefficient ($e^\beta$), researchers obtain the odds ratio. An OR greater than 1 means $X$ increases the odds of the outcome. An OR less than 1 means $X$ decreases the odds. For example, if $e^{\beta_1} = 2$, a one-unit increase in $X$ doubles the odds of $Y=1$.
2. Marginal Effects: To estimate the approximate change in probability, researchers apply the "divide by 4" rule. Dividing the Logit coefficient by 4 gives the maximum marginal effect of $X$ on the probability, which occurs precisely when the predicted probability is 0.5. 

Logit models provide robust, mathematically sound estimates for binary outcomes and are the standard in modern quantitative analysis for discrete choice problems.

## References and Materials

- [W3. Literature review.pptx](./W3.%20Literature%20review.pptx)
- [W3. Logistic link model 1.pptx](./W3.%20Logistic%20link%20model%201.pptx)
- [W3. Linear regression.R](./W3.%20Linear%20regression.R)
- [W3. Zotero.docx](./W3.%20Zotero.docx)
