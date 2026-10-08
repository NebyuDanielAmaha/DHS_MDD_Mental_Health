## 📖 Project Description

### Background
Depression and anxiety disproportionately affect women in low- and middle-income countries (LMICs), leading to substantial adverse social, maternal, and economic outcomes. While poor diet quality and psychosocial stress are individually recognized as major contributors to common mental disorders, evidence linking Minimum Dietary Diversity for Women (**MDD-W**) with depressive and anxiety symptoms in LMICs remains limited—particularly after accounting for key psychosocial stressors such as exposure to intimate partner violence (IPV).

### Objective & Research Scope
This project evaluates the cross-sectional association between achieving minimum dietary diversity ($\ge 5$ of 10 food groups consumed in the preceding 24 hours) and the prevalence of moderate-to-severe depressive symptoms (**PHQ-9** $\ge 10$) and anxiety symptoms (**GAD-7** $\ge 10$) among women of reproductive age (15–49 years). 

The primary analytic workflow involves:
1. **Multi-Country Data Harmonization**: Standardizing Demographic and Health Survey Phase 8 (**DHS-8**) Individual Recode (`IR`) datasets across four diverse LMIC settings:
   * 🇱🇸 **Lesotho** (2023–24)
   * 🇲🇿 **Mozambique** (2022–23)
   * 🇳🇵 **Nepal** (2022)
   * 🇿🇲 **Zambia** (2024)
2. **Subpopulation Filtering**: Restricting analyses to women selected for and responding to the Domestic Violence module (`v044 == 1`) to enable robust adjustment for physical and sexual violence exposure.
3. **Complex Survey Modeling**: Fitting survey-weighted Poisson regression models with robust error variances to estimate country-specific unadjusted and adjusted prevalence ratios (aPRs), accounting for multi-stage cluster sampling, stratification, and sample weights (`wt_dv`).
4. **Meta-Analysis**: Pooling country-specific adjusted estimates using random-effects meta-analysis with Restricted Maximum Likelihood (**REML**) estimation to evaluate overarching regional associations and between-country heterogeneity ($I^2$).

### Key Findings
* **Dietary Diversity Coverage**: Prevalence of achieving MDD-W varied widely across study sites: **17.6%** in Lesotho, **19.7%** in Mozambique, **26.7%** in Zambia, and **55.3%** in Nepal.
* **Country-Specific Associations**:
  * **Depression**: Achieving MDD-W was significantly associated with a 34% lower prevalence of moderate-to-severe depressive symptoms in Mozambique ($\text{aPR} = 0.66$, $95\%\text{ CI: } 0.47\text{–}0.92$).
  * **Anxiety**: Inverse associations were observed in Mozambique ($\text{aPR} = 0.70$, $95\%\text{ CI: } 0.52\text{–}0.95$) and Nepal ($\text{aPR} = 0.74$, $95\%\text{ CI: } 0.56\text{–}0.98$).
* **Pooled Meta-Analysis Results**:
  * **Depressive Symptoms**: Achieving MDD-W was associated with a **24% lower pooled prevalence** of moderate-to-severe depressive symptoms ($\text{pooled aPR} = 0.76$, $95\%\text{ CI: } 0.62\text{–}0.94$; $I^2 = 3.6\%$).
  * **Anxiety Symptoms**: Achieving MDD-W was associated with a **20% lower pooled prevalence** of moderate-to-severe anxiety symptoms ($\text{pooled aPR} = 0.80$, $95\%\text{ CI: } 0.64\text{–}1.00$; $I^2 = 31.4\%$).

### Public Health Significance
These findings demonstrate that meeting minimum dietary diversity guidelines is consistently associated with lower odds of experiencing moderate-to-severe depressive and anxiety symptoms among women in LMICs, independent of sociodemographic factors and physical/sexual violence exposure. Nutrition-sensitive public health strategies and integrated interventions addressing both food security and mental healthcare may serve as vital platforms to improve women's health in resource-limited settings.
