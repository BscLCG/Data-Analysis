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

## Detailed Reading 1: Formulating Problems and Designing Research

A research project begins with identifying a specific, real-world problem. This problem drives the subsequent formulation of research questions and the selection of a research design. Researchers cannot select methods (such as surveys or interviews) before defining the exact question they aim to answer. Doing so leads to structural errors and wasted resources.

The process follows a linear logic: problem → question → design. The research problem establishes the context and the deficiency in existing knowledge. Once the problem is clear, the researcher drafts a primary research question. This question must be answerable through empirical data. Broad, philosophical questions do not work in empirical research. The question dictates the approach. If the question asks "how much" or "to what extent," the researcher needs a [quantitative design](../W6_Data_collection/README.md). If the question asks "how" or "why" individuals interpret an event, the researcher needs a qualitative design. 

The choice of design directly impacts the variables and data structures used later in the study. In quantitative designs, the researcher must operationalize concepts into measurable variables. The nature of these variables (continuous, binary, ordinal) restricts the statistical models available for analysis. A continuous outcome variable allows for linear regression models, while a binary outcome variable (e.g., yes/no responses) requires [logistic regression models](../W3_Literature_review_and_Logistic/README.md). 

By establishing the correct design from the outset, researchers avoid mismatched data and models.

## Detailed Reading 2: Exploratory Data Analysis and Linear Regression

Exploratory Data Analysis (EDA) is the first step in quantitative data analysis. It allows the researcher to understand data distributions, identify missing values, and locate outliers before applying formal statistical models. EDA relies on graphical and non-graphical techniques. 

Non-graphical techniques calculate summary statistics. For single variables, researchers calculate measures of central tendency (mean, median) and measures of dispersion (variance, standard deviation, interquartile range). For relationships between two variables, researchers use cross-tabulation and correlation coefficients. The Pearson correlation measures the strength and direction of linear relationships between two continuous variables. The Spearman correlation measures monotonic relationships using rank-ordered data.

Graphical techniques provide visual representations of the data. Histograms and box plots show the distribution and central tendency of a single variable, highlighting potential outliers. Scatter plots visualize the relationship between two continuous variables, indicating whether a linear association exists. In this course, researchers implement these graphical techniques using the `ggplot2` package in R.

After EDA, researchers move to statistical modeling. Simple Linear Regression estimates the relationship between a single independent variable ($x$) and a continuous dependent variable ($y$). The model fits a straight line through the data points using the equation $y = \beta_0 + \beta_1 x + u$, where $\beta_0$ is the intercept, $\beta_1$ is the slope, and $u$ represents the unobserved error term.

The standard method for estimating the parameters ($\beta_0$ and $\beta_1$) is Ordinary Least Squares (OLS). OLS calculates the line that minimizes the sum of squared differences between the observed values and the values predicted by the model. 

OLS estimation relies on specific statistical assumptions to produce valid results:
1. Linearity in parameters.
2. Random sampling from the population.
3. No perfect collinearity.
4. Zero conditional mean of the error term.
5. Homoscedasticity (constant variance of the error term).

When these assumptions hold, OLS provides the best linear unbiased estimator of the population parameters. Researchers use the output of OLS models to understand the magnitude and direction of the effect $x$ has on $y$, always remembering that correlation in observational data does not prove causality.

## References and Materials

- [W2. EDA and linear regression.pptx](./W2.%20EDA%20and%20linear%20regression.pptx)
- [W2. Problem and research questions - Copy.pptx](./W2.%20Problem%20and%20research%20questions%20-%20Copy.pptx)
- [W2. From problem to question to design.docx](./W2.%20From%20problem%20to%20question%20to%20design.docx)
