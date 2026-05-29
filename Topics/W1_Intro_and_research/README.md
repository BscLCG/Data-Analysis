# Week 1: Introduction and Research Approaches

> [!info] Overview
>
> This section introduces the foundational competencies for data analysis and research methodology. It covers the structural integration of Large Language Models (LLMs) in academic settings, the philosophical assumptions guiding research design, and the distinction between research approaches. It also establishes the technical tooling (R, RStudio, and R Markdown) required for reproducible workflows.

## Required and Complementary Readings
* [Creswell, J. W., & Creswell, J. D. (2023). *Research design: Qualitative, quantitative, and mixed methods approach* (Sixth edition).](../../References/John%20W.%20Creswell,%20David%20J.%20Creswell%20-%20Research%20Design%20Qualitative,%20Quantitative,%20and%20Mixed%20Methods%20Approaches.pdf) Sage. (pp. 30–52)

## Detailed Reading: Worldviews and Reproducibility

### The Role of Large Language Models in Research
Large Language Models (LLMs) operate as probabilistic prediction engines. They lack understanding, factual verification, and agency. When generating text, an LLM selects statistically probable words based on training data patterns, which often produces plausible but false information (hallucination).

Academic research demands strict oversight when integrating LLMs. While researchers use them to summarize literature or draft code, deploying AI outputs without manual verification causes factual errors and plagiarism. Institutional guidelines require researchers to disclose AI assistance and assume full responsibility for the accuracy of their work. Researchers must verify every claim, citation, and data point against primary sources.

### Philosophical Assumptions in Research
Research designs follow the philosophical assumptions (worldviews) of the researcher. These assumptions dictate what constitutes valid knowledge. The social and behavioral sciences rely on four primary worldviews:

1. **Positivist Worldview**: Deterministic and reductionist. It assumes causes determine effects. Researchers isolate discrete variables to test hypotheses through empirical observation and measurement. This worldview forms the foundation of quantitative research, designed to test [theories deductively](../W4_1_Use_of_Theory/README.md).
2. **Constructivist Worldview**: Interpretative. It assumes individuals develop subjective meanings from their experiences. Researchers examine the complexity of these views rather than reducing them to narrow categories. This is the foundation of qualitative research.
3. **Transformative Worldview**: Political and change-oriented. It integrates research with an agenda to confront social oppression and empower marginalized groups. It includes frameworks like feminist, racialized, and critical theory.
4. **Pragmatic Worldview**: Problem-centered and pluralistic. It focuses on practical outcomes and solutions rather than strict philosophical conditions. Researchers use all available approaches to understand the problem. This underpins [Mixed Methods](../W5_1_Mixed_Methods/README.md) research.

### Research Approaches and Designs
A research approach defines the structural procedure from broad assumptions to specific data collection methods.

* **Quantitative research**: Tests objective theories by examining relationships among measurable variables. It relies on numbered data analyzed through statistical procedures.
* **Qualitative research**: Explores the meaning individuals ascribe to social problems. It uses inductive data analysis, building from particulars to general themes based on qualitative data (words, observations).
* **Mixed methods research**: Collects and integrates both quantitative and qualitative data. It operates under the assumption that combining approaches yields a more complete understanding of the research problem.

### Tooling for Reproducible Research
Data analysis requires software to manipulate datasets, execute statistical tests, and document the workflow. This course utilizes R and RStudio. R is a programming language built for statistical computing, while RStudio serves as its integrated development environment (IDE).

Reproducibility is a mandatory requirement in modern analysis. It means an independent researcher can take the original data and code, run it, and produce the exact same results. To guarantee reproducibility, researchers use R Markdown. R Markdown integrates executable R code with narrative text. Upon rendering, it executes the code and embeds the outputs (tables, plots) directly into a final document. This workflow eliminates manual copying and pasting, directly preventing transcription errors in academic reporting.

> [!tip] Cross-References
>
> * Return to the [Course Root](../../README.md)
> * Next topic: [Problem Formulation and Research Questions](../W2_1_Problem_and_Research_Questions/README.md)

> [!note] References and Materials
>
> **View (PDFs)**
> - [W1. Intro and research approaches.pdf](./W1.%20Intro%20and%20%20research%20approaches.pdf)
> - [W1. DOA.pdf](./W1.%20DOA.pdf)
> - [W1. R studio y markdown.pdf](./W1.%20R%20studio%20y%20markdown.pdf)
>
> **Download (Originals & Scripts)**
> - [W1. Intro and research approaches.pptx](./W1.%20Intro%20and%20%20research%20approaches.pptx)
> - [W1. DOA.docx](./W1.%20DOA.docx)
> - [W1. R studio y markdown.docx](./W1.%20R%20studio%20y%20markdown.docx)
