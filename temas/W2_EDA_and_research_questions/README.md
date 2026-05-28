# Week 2: Exploratory Data Analysis and Research Questions

## Overview

This week focuses on two core components of the research process: transitioning from a research problem to a solid research design, and conducting Exploratory Data Analysis (EDA). The materials cover how to explore data distributions and relationships using graphical and non-graphical techniques. Furthermore, it introduces the foundational concepts of Simple Linear Regression and Ordinary Least Squares (OLS) estimation.

## Key Concepts

- **Exploratory Data Analysis (EDA):** Examining data without formal statistical modeling to understand distributions, relationships, and identify outliers.
  - *Graphical Techniques:* Histograms, bar plots, line plots, scatter plots, and box plots (often implemented via `ggplot2` in R).
  - *Non-Graphical Techniques:* Measures of central tendency (mean, median), variance, standard deviation, interquartile range (IQR), cross-tabulation, and correlation (Pearson, Spearman).
- **Simple Linear Regression:** A method to relate a continuous dependent variable to an independent variable using a straight line equation ($y = \beta_0 + \beta_1 x + u$).
- **Ordinary Least Squares (OLS):** An estimation method that minimizes the residual sum of squares to find the best-fitting line. Key assumptions (LSA) include linearity, random sampling, conditional mean zero, and homoscedasticity.
- **From Problem to Design:** The sequence of moving from identifying a core research problem to formulating specific research questions, and ultimately choosing an appropriate research design.

## Relevant Points

- **Design Before Methods:** The research design must be driven by the nature of the research problem. Changing the design later to accommodate specific methods is costly and inefficient.
- **Data Types and Models:** Identifying whether the outcome variable is numerical, categorical (binary, ordered, multinomial), and understanding the data structure is crucial for selecting the correct model (e.g., Logit vs. Linear Regression).
- **Correlation vs. Causality:** Correlation coefficients measure linear association but do not imply causality. Causal inference requires careful design considerations beyond statistical correlation.

## References and Materials

- [W2. EDA and linear regression.pptx](./W2.%20EDA%20and%20linear%20regression.pptx)
- [W2. Problem and research questions - Copy.pptx](./W2.%20Problem%20and%20research%20questions%20-%20Copy.pptx)
- [W2. From problem to question to design.docx](./W2.%20From%20problem%20to%20question%20to%20design.docx)
