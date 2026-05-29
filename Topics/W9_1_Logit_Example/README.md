# Week 9.1: Logit Example

> [!info] Overview
> This section presents a practical application of logistic regression, analyzing racial discrimination in the sharing economy through field experiments.

## Required and Complementary Readings
* Edelman, B., Luca, M., & Svirsky, D. (2017). Racial Discrimination in the Sharing Economy: Evidence from a Field Experiment. *American Economic Journal: Applied Economics*, 9(2), 1–22.

## Detailed Reading: Analyzing Discrimination

[Logistic regression](../W3_2_Logistic_Regression/README.md) models complex binary outcomes in real-world scenarios. In 2017, Edelman, Luca, and Svirsky measured racial discrimination in the Airbnb rental market. The platform relies on host decisions to accept or reject guests—a binary outcome perfectly suited for a logit model.

### Quasi-Experimental Design
To measure discrimination accurately, the researchers used a quasi-experimental design. They created fictitious guest profiles and sent rental requests to hosts. The profiles were identical in every characteristic except for the name, which signaled either a White or African American identity. This design isolates the race variable. If African American profiles receive systematically lower acceptance rates, the difference is directly attributable to racial discrimination by the hosts.

### Results and Homophily
The data revealed a significant gap: White guests received a positive response rate of 48.78%, whereas African American guests faced a rejection rate over 50%. The model identified a discrimination gap of approximately 8 percentage points against African American guests (a 16% differential in relative acceptance rates). 

Logistic regression demonstrated that this gap persisted even when controlling for host demographics, physical listing characteristics, and neighborhood census tracts. The researchers also tested for *homophily*—the tendency of individuals to associate with similar others. The data showed no general homophily effect; African American male hosts reported an acceptance gap of 25 percentage points favoring White guests over African American guests.

### Validity Critiques
While the statistical model is robust, all experimental designs must be evaluated for validity:
- **Internal Validity**: The extent to which a study isolates the causal mechanism. Critics note that the sample contained very few same-race/same-gender interactions (1.92% of all host-guest pairs), limiting the statistical power to draw definitive conclusions about intragroup discrimination.
- **External Validity**: The extent to which findings generalize to other populations. The experiment heavily sampled hosts from large urban centers. This geographic concentration suggests the observed discrimination effects might be locally specific rather than a universal platform feature.

> [!tip] Cross-References
> * Return to the [Course Root](../../README.md)
> * Previous topic: [Writing and Ethics](../W8_1_Writing_and_Ethics/README.md)
> * Next topic: [Causal Mediation Analysis](../W13_1_Mediation/README.md)

> [!note] References and Materials
> **View (PDFs)**
> - [W9.poster 01.pdf](./W9.poster%2001.pdf)
>
> **Download (Originals & Scripts)**
> - [W9. class example logit.R](./W9.%20class%20example%20logit.R)
> - [W9.poster 01.pptx](./W9.poster%2001.pptx)
