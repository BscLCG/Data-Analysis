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

## References and Materials

- [W13.Mediation.R](./W13.Mediation.R)
