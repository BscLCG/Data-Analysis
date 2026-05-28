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

## References and Materials

- [W3. Literature review.pptx](./W3.%20Literature%20review.pptx)
- [W3. Logistic link model 1.pptx](./W3.%20Logistic%20link%20model%201.pptx)
- [W3. Linear regression.R](./W3.%20Linear%20regression.R)
- [W3. Zotero.docx](./W3.%20Zotero.docx)
