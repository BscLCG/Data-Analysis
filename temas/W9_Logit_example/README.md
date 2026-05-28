# Week 9: Logit Example - Discrimination in the Sharing Economy

## Overview

This week presents a practical application of Logistic Regression to analyze racial discrimination in the sharing economy, specifically focusing on the Airbnb rental market. Using the field experiment by Edelman, Luca, and Svirsky (2017), the materials explore how quantitative models evaluate discrimination conditional on host and listing characteristics, and how to critique the validity of experimental designs.

## Key Concepts

- **Quasi-Experimental Design:** A setup where all variables are kept equal (e.g., identical rental requests) except for the treatment variable (implied race via names).
- **Discrimination Measurement:** Evaluating differences in acceptance/rejection rates between different demographic groups using statistical models.
- **Homophily:** The tendency of individuals to associate and bond with similar others (e.g., same race-gender interactions between hosts and guests).
- **Internal Validity:** The extent to which a study establishes a trustworthy cause-and-effect relationship (critiqued here due to low numbers of same-race interactions and potential measurement errors).
- **External Validity:** The extent to which study findings can be generalized to other settings or populations (critiqued here due to the geographic concentration of the sample).

## Relevant Points

- **Significant Findings:** The study found a statistically significant discrimination gap (around 16%) against African American guests, persistent across different host races and physical listing characteristics.
- **Marginal Effects:** The logistic model provides insights into the marginal probability of acceptance based on the guest's race.
- **Critique:** The experiment's results, while robust, face valid critiques regarding unobserved confounders in intragroup discrimination and the generalizability of results derived from specific geographic locations.

## Detailed Reading: Analyzing Discrimination with Logistic Regression

[Logistic regression](../W3_Literature_review_and_Logistic/README.md) allows researchers to model complex binary outcomes in real-world scenarios. A prime example is the study of discrimination within sharing economy platforms. In 2017, researchers Edelman, Luca, and Svirsky designed a field experiment to measure racial discrimination in the Airbnb rental market. Because the platform relies on host decisions to accept or reject guests (a strictly binary outcome), it provides an ideal dataset for a Logit model.

To measure discrimination accurately, the researchers used a quasi-experimental design. They created fictitious guest profiles and sent rental requests to hosts. The profiles were identical in every characteristic except for the name of the guest, which signaled either a White or African American identity. This design isolates the variable of race. If African American profiles receive systematically different acceptance rates than White profiles, the difference is attributable to racial discrimination by the hosts.

The results demonstrated a significant gap. White guests received a positive response rate of 48.78%. African American guests faced a rejection rate over 50%. The model identified a discrimination gap of approximately 8 percentage points against African American guests, representing a 16% differential in acceptance rates.

The researchers used logistic regression to test if this gap persisted when controlling for other variables. First, they controlled for host demographics. The data showed that the discrimination gap existed regardless of whether the host was White or African American. Second, they controlled for the physical characteristics of the listing and its geographic census tract. Keeping the physical listing and neighborhood constant, the model still showed that requests from African American guests were rejected at an 8 percentage point higher rate than those from White guests. Furthermore, interactions between race and price indicators showed a statistically significant 7 percentage point decline in acceptance probability for African American requests at specific price points.

The researchers also investigated homophily, the tendency of individuals to associate with similar others. They tested whether same-race and same-gender interactions between hosts and guests altered the acceptance rates. The data revealed a general absence of homophily. Only African American female hosts showed a higher acceptance rate for African American female guests (a marginal effect of 2 percentage points). Conversely, African American male hosts reported an acceptance gap of 25 percentage points favoring White guests over African American guests. 

While the statistical model proved robust, researchers must always evaluate the internal and external validity of experimental designs. 

Internal validity refers to how accurately the experiment isolates the causal mechanism without confounding variables. Critics point out that the sample contained very few same-race/same-gender interactions (only 1.92% of all host-guest pairs). This low frequency limits the statistical power to draw definitive conclusions about intragroup discrimination. Additionally, if the third-party software incorrectly classified control variables, measurement errors could bias the estimated discrimination gap.

External validity refers to how well the findings generalize to other populations or locations. The experiment heavily sampled hosts from specific urban centers like Los Angeles and Washington, D.C. This geographic concentration suggests that the observed discrimination effects might be locally specific and heavily influenced by the hedonic characteristics of those specific cities, rather than representing a universal truth across the entire platform. 

Future research must use stratified sampling to ensure broader geographic and racial distribution, allowing for a more comprehensive test of the discrimination hypothesis across different markets.

## References and Materials

- [W9.poster 01.pptx](./W9.poster%2001.pptx)
