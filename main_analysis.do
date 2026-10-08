/*********************************************************************
  DHS
*********************************************************************/
* FILTER THOSE WITH DV MODULE

keep if v044==1

/* DEFINE YES/NO LABEL AND WEIGHT */
cap label define yesno 0 "No" 1 "Yes"
gen wt_dv = d005/1000000

**************************************************************************
* OUTCOME VARIABLE
**************************************************************************/

* Depression
gen phq9_total = mth8 + mth9 + mth10 + mth11 + mth12 + mth13 + mth14 + mth15 + mth16
gen depression = phq9_total >= 10 if phq9_total < .
gen m_depression = phq9_total >= 5 if phq9_total < .
label define dep 0 "No depression" 1 "Depressed"
label values depression dep
label values m_depression dep
label variable depression "Depression (PHQ-9 = 10)"

* Anxiety
gen gad7_total = mth1 + mth2 + mth3 + mth4 + mth5 + mth6 + mth7
gen anxiety_gad = 0
gen m_anxiety_gad = gad7_total >=5 if gad7_total < .
replace anxiety_gad = 1 if gad7_total >= 6
replace anxiety_gad = . if missing(gad7_total)


* Depression 2
gen depression2 = phq9_total >= 10 if phq9_total < .
label define dep2 0 "No depression" 1 "Depressed"
label values depression2 dep2
label variable depression2 "Depression (PHQ-9 = 10)"

* Anxiety 2
gen anxiety2 = 0
replace anxiety2 = 1 if gad7_total >= 10
replace anxiety2 = . if missing(gad7_total)

label define anx2 0 "No anxiety" 1 "Anxiety"
label values anxiety2 anx2
label variable anxiety2 "Anxiety (GAD-7 = 10)"


/**************************************************************************
* EXPOSURE
**************************************************************************/

/* FOOD & LIQUIDS CONSUMED (15-49) */
gen nt_wm_grains = (v472e == 1)
label values nt_wm_grains yesno
label var nt_wm_grains "Woman had grains in day/night before survey"

gen nt_wm_root = (v472f == 1)
label values nt_wm_root yesno
label var nt_wm_root "Woman had roots/tubers in day/night before survey"

gen nt_wm_beans = (v472o == 1)
label values nt_wm_beans yesno
label var nt_wm_beans "Woman had beans/peas/lentils in day/night before survey"

gen nt_wm_nuts = (v472c == 1)
label values nt_wm_nuts yesno
label var nt_wm_nuts "Woman had nuts or seeds in day/night before survey"

gen nt_wm_dairy = (v472p == 1)
label values nt_wm_dairy yesno
label var nt_wm_dairy "Woman had milk/cheese/yogurt in day/night before survey"

gen nt_wm_meatfish = (v472b == 1) | (v472h == 1) | (v472m == 1) | (v472n == 1)
label values nt_wm_meatfish yesno
label var nt_wm_meatfish "Woman had meat/fish/poultry/organ meats in day/night before survey"

gen nt_wm_eggs = (v472g == 1)
label values nt_wm_eggs yesno
label var nt_wm_eggs "Woman had eggs in day/night before survey"

gen nt_wm_dkgreens = (v472j == 1)
label values nt_wm_dkgreens yesno
label var nt_wm_dkgreens "Woman had dark green leafy vegetables in day/night before survey"

gen nt_wm_vita = (v472i == 1) | (v472k == 1)
label values nt_wm_vita yesno
label var nt_wm_vita "Woman had vitamin A rich foods in day/night before survey"

gen nt_wm_veg = (v472a == 1)
label values nt_wm_veg yesno
label var nt_wm_veg "Woman had other vegetables in day/night before survey"

gen nt_wm_fruit = (v472l == 1)
label values nt_wm_fruit yesno
label var nt_wm_fruit "Woman had other fruits in day/night before survey"

gen nt_wm_insect = (v472d == 1)
label values nt_wm_insect yesno
label var nt_wm_insect "Woman had insects/other small protein in day/night before survey"

gen nt_wm_palm = (v472u == 1)
label values nt_wm_palm yesno
label var nt_wm_palm "Woman had palm oil in day/night before survey"

gen nt_wm_sweets = (v472r == 1) | (v472w == 1)
label values nt_wm_sweets yesno
label var nt_wm_sweets "Woman had sweet foods in day/night before survey"

gen nt_wm_salty = (v472t == 1)
label values nt_wm_salty yesno
label var nt_wm_salty "Woman had salty foods in day/night before survey"

gen nt_wm_juice = (v471e == 1)
label values nt_wm_juice yesno
label var nt_wm_juice "Woman had fruit juice in day/night before survey"

gen nt_wm_soda = (v471d == 1)
label values nt_wm_soda yesno
label var nt_wm_soda "Woman had soda/energy drink in day/night before survey"

gen nt_wm_teacoff = (v471b == 1)
label values nt_wm_teacoff yesno
label var nt_wm_teacoff "Woman had tea/coffee/herbal drink in day/night before survey"

gen nt_wm_swt_drink = (v471cs == 1) | (v471d == 1) | (v471e == 1) | (v472v == 1)
label values nt_wm_swt_drink yesno
label var nt_wm_swt_drink "Woman had sweet beverage in day/night before survey"

gen nt_wm_unhlth_food = (nt_wm_sweets==1) | (nt_wm_salty==1)
label values nt_wm_unhlth_food yesno
label var nt_wm_unhlth_food "Woman had unhealthy foods in day/night before survey"

/* MINIMUM DIETARY DIVERSITY (MDD-W) - 10 food groups */
gen group1 = (nt_wm_grains==1) | (nt_wm_root==1)
gen group2 = (nt_wm_beans==1)
gen group3 = (nt_wm_nuts==1)
gen group4 = (nt_wm_dairy==1)
gen group5 = (nt_wm_meatfish==1)
gen group6 = (nt_wm_eggs==1)
gen group7 = (nt_wm_dkgreens==1)
gen group8 = (nt_wm_vita==1)
gen group9 = (nt_wm_veg==1)
gen group10 = (nt_wm_fruit==1)

* sum the groups (use rowtotal)
egen foodsum = rowtotal(group1 group2 group3 group4 group5 group6 group7 group8 group9 group10)

* create MDD-W: 1 if >=5 groups, 0 if <5, . if missing
gen nt_wm_mdd = .
replace nt_wm_mdd = 1 if foodsum >= 5
replace nt_wm_mdd = 0 if foodsum < 5 & foodsum >= 0
label values nt_wm_mdd yesno
label var nt_wm_mdd "Woman with minimum dietary diversity (>=5/10)"

* High fruit and vegetable diet
egen hfv_count = rowtotal(group7 group8 group9 group10)
gen nt_wm_hfv2 = .
replace nt_wm_hfv2 = 0 if hfv_count < 3
replace nt_wm_hfv2 = 1 if hfv_count >= 3
label define hfv2 0 "Low (<3 groups)" 1 "High (>=3 groups)"
label values nt_wm_hfv2 hfv2


/**************************************************************************
* COVARIATES
**************************************************************************/

* AGE CATEGORIES INTO 3
gen age_cat3=.
replace age_cat3 = 1 if inrange(v012, 15, 19)
replace age_cat3 = 2 if inrange(v012, 20, 34)
replace age_cat3 = 3 if inrange(v012, 35, 49)

label define agegroup_labels3 1 "15-19 years" 2 "20-34 years" 3 "35-49 years"
label values age_cat3 agegroup_labels3


* EDUCATION INTO 2
gen education_cat2 = .
replace education_cat2 = 0 if inlist(v106,0,1) // no and primary
replace education_cat2 = 1 if inlist(v106,2,3) // secondary and higher

label define edu_cat2_lbl 0 "Below Secondary" 1 "Secondary & Above"
label values education_cat2 edu_cat2_lbl



* MARITAL STATUS INTO 3
gen marital_cat3=3
replace marital_cat3=1 if v501==0
replace marital_cat3=2 if v501==1

label define marstatus_labels 1 "Never in union" 2 "Married" 3 "Formerly in union"
label values marital_cat3 marstatus_labels

* WEALTH INTO 2
generate wealth_cat2 = .
replace wealth_cat2 = 0 if inlist(v190, 1, 2, 3) // Assign 0 for Low wealth
replace wealth_cat2 = 1 if inlist(v190, 4, 5)   // Assign 1 for High wealth
label define wealth_cat2_lbl 0 "Low wealth" 1 "High wealth"
label values wealth_cat2 wealth_cat2_lbl

* AGE AT FIRST BIRTH
gen agefb18 = . 
replace agefb18 = 0 if v212 < 18   // below 18 years
replace agefb18 = 1 if v212 >= 18  // 18 or above
label define agefb18lbl 0 "Below 18" 1 "18 or above"
label values agefb18 agefb18lbl

* PARITY
gen parity_cat = .
replace parity_cat = 0 if v201 == 0
replace parity_cat = 1 if inrange(v201,1,2)
replace parity_cat = 2 if v201 >= 3

label define paritylbl 0 "0 children" 1 "1–2 children" 2 "3 or more children"
label values parity_cat paritylbl

* BMI INTO 3
replace v445 = . if v445 >= 9998 
replace v445 = . if v445 == 0
gen bmi_cat3 = .
replace bmi_cat3 = 1 if v445 < 1850
replace bmi_cat3 = 2 if v445 >= 1850 & v445 < 2500
replace bmi_cat3 = 3 if v445 >= 2500
label define bmi3_l 1 "Underweight (<18.5)" 2 "Normal (18.5-24.9)" 3 "Overweight/Obese (>=25.0)"
label values bmi_cat3 bmi3_l
label variable bmi_cat3 "BMI Category"

* FOR NEPAL ONLY BMI CAT 3
* BMI INTO 3
replace v446d = . if v446d >= 9998 
replace v446d = . if v446d == 0
gen bmi_cat3 = .
replace bmi_cat3 = 1 if v446d < 1850
replace bmi_cat3 = 2 if v446d >= 1850 & v445 < 2500
replace bmi_cat3 = 3 if v446d >= 2500
label define bmi3_l 1 "Underweight (<18.5)" 2 "Normal (18.5-24.9)" 3 "Overweight/Obese (>=25.0)"
label values bmi_cat3 bmi3_l
label variable bmi_cat3 "BMI Category"


* BMI INTO 2

gen bmi_cat2 = .
replace bmi_cat2 = 1 if v445 < 2500
replace bmi_cat2 = 2 if v445 >= 2500
label define bmi2_l 1 "Not-overweight/Obese (<18.5)" 2 "Overweight/Obese (>=25.0)"
label values bmi_cat2 bmi2_l
label variable bmi_cat2 "Overweight/Obese category"


* AUTONOMY (based on jusifying wife beating)

gen autonomy_proxy = 1
label var autonomy_proxy "Proxy for High Autonomy (Rejects all Wife Beating Justifications)"
replace autonomy_proxy = 0 if v744a==1 | v744b==1 | v744c==1 | v744d==1 | v744e==1
gen valid_response_flag = 0
replace valid_response_flag = 1 if v744a!=. & v744a<8
replace valid_response_flag = 1 if v744b!=. & v744b<8
replace valid_response_flag = 1 if v744c!=. & v744c<8
replace valid_response_flag = 1 if v744d!=. & v744d<8
replace valid_response_flag = 1 if v744e!=. & v744e<8

replace autonomy_proxy = . if valid_response_flag == 0 
drop valid_response_flag
label define autonomy_l 1 "High Autonomy (Rejects all beating)" 0 "Low Autonomy (Accepts beating)"
label values autonomy_proxy autonomy_l

tab autonomy_proxy, missing

* Catholic or not

gen is_catholic = 0
label var is_catholic "Religion: Catholic vs. Non-Catholic (Harmonized)"
replace is_catholic = 1 if v130 == 1

*For Neapal only
*replace is_catholic = 1 if v130 == 5

replace is_catholic = . if v130 == . 
replace is_catholic = . if v130 >= 99 
label define catholic_l 1 "Catholic" 0 "Non-Catholic"
label values is_catholic catholic_l
tab is_catholic, missing

/* IPV INDICATORS*/

**EXPERIENCED PHYSICAL VIOLENCE
		//ever
		gen dv_phy = 0 if v044==1
		foreach z in a b c d e f g j {
		replace dv_phy = 1 if d105`z'>=1 & d105`z'<=4 //violence by current partner
		}
		replace dv_phy = 1 if d130a>=1 & d130a<=4	  //violence by former partner
		replace dv_phy = 1 if d115y==0				  //violence by anyone other than partner
		replace dv_phy = 1 if d118y==0				  //violence during pregnancy
		label var dv_phy	"Experienced physical violence since age 15"
		label val dv_phy yesno
		
		//in the last 12 months
		gen dv_phy_12m = 0 if v044==1 
		foreach z in a b c d e f g j {
		replace dv_phy_12m = 1 if d105`z'==1 | d105`z'==2 
		}
		replace dv_phy_12m = 1 if d117a==1 | d117a==2 | d130a==1
		label val dv_phy_12m yesno
		label var dv_phy_12m	"Experienced physical violence in past 12 mos"
	
		//in the last 12 months by frequency (often or sometimes)
		gen dv_phy_12m_f = 0 if v044==1
		foreach z in a b c d e f g j {
		replace dv_phy_12m_f = 2 if d105`z'==2 | d117a==2  //sometimes
		}
		foreach z in a b c d e f g j {
		replace dv_phy_12m_f = 1 if d105`z'==1 | d117a==1  //often
		}
		label define lab_12m_f 0 "no" 1 "often" 2 "sometimes"
		label val dv_phy_12m_f lab_12m_f
		label var dv_phy_12m_f	"Experienced physical violence in the past 12 mos, frequency"

	//physical violence during pregnancy
	gen dv_phy_preg = 0 if v044==1 & (v201>0 | v213==1 | v228==1) //Ever had a pregnancy
	replace dv_phy_preg = 1 if d118y==0		
	label val dv_phy_preg yesno
	label var dv_phy_preg	"Experienced physical violence during pregnancy"


**EXPERIENCED SEXUAL VIOLENCE
		//ever 
		gen dv_sex = 0 if v044==1
		foreach z in h i k  {
		replace dv_sex = 1 if d105`z'>=1 & d105`z'<=4 //violence by current partner
		}
		replace dv_sex = 1 if d130b>=1 & d130b<=4	  //violence by former partner
		replace dv_sex = 1 if d124==1				  //violence by anyone other than partner
		replace dv_sex = 1 if d125==1				  //forced to perform unwanted acts
		label var dv_sex	"Ever experienced sexual violence"
		label val dv_sex yesno
		
		//in the last 12 months
		gen dv_sex_12m = 0 if v044==1
		foreach z in h i k {
		replace dv_sex_12m = 1 if d105`z'==1 | d105`z'==2 
		}
		replace dv_sex_12m = 1 if d130b==1 | d124==1
		label val dv_sex_12m yesno
		label var dv_sex_12m	"Experienced sexual violence in past 12 mos"
	
		//in the last 12 months by frequency (often or sometimes)
		gen dv_sex_12m_f = 0 if v044==1
		foreach z in h i k {
		replace dv_sex_12m_f = 2 if d105`z'==2 | d117a==2  //sometimes
		}
		foreach z in h i k {
		replace dv_sex_12m_f = 1 if d105`z'==1 | d117a==1  //often
		}
		label define lab_12m_sex_f 0 "no" 1 "yes, often" 2 "yes, sometimes"
		label val dv_sex_12m_f lab_12m_sex_f
		label var dv_sex_12m_f	"Experienced sexual violence in the past 12 mos, frequency"

**EXPERIENCED PHYSICAL AND SEXUAL VIOLENCE
		//ever
		gen dv_phy_sex = 0 if v044==1
		replace dv_phy_sex = 1 if (dv_phy==1 & dv_sex==1)
		label val dv_phy_sex yesno
		label var dv_phy_sex	"Ever experienced physical AND sexual violence"

		//in the last 12 months
		gen dv_phy_sex_12m = 0 if v044==1 
		replace dv_phy_sex_12m = 1 if (dv_phy_12m==1 & dv_sex_12m==1)
		label val dv_phy_sex_12m yesno
		label var dv_phy_sex_12m	"Experienced physical AND sexual violence in the last 12 months"

		//in the last 12 months by frequency (often or sometimes)
		gen dv_phy_sex_12m_f = 0 if v044==1
		replace dv_phy_sex_12m_f = 1 if (dv_phy_12m==1 & dv_sex_12m==1)
		replace dv_phy_sex_12m_f = 2 if (dv_phy_12m==2 & dv_sex_12m==2)
		label val dv_phy_sex_12m_f frequency
		label var dv_phy_sex_12m_f	"Experienced physical AND sexual violence in the last 12 months, frequency"

**EXPERIENCED PHYSICAL OR SEXUAL VIOLENCE
		//ever
		gen dv_phy_sex_any = 0 if v044==1
		replace dv_phy_sex_any = 1 if (dv_phy==1 | dv_sex==1)
		label val dv_phy_sex_any yesno
		label var dv_phy_sex_any	"Ever experienced physical OR sexual violence"

		//in the last 12 months
		gen dv_phy_sex_any_12m = 0 if v044==1
		replace dv_phy_sex_any_12m = 1 if (dv_phy_12m==1 | dv_sex_12m==1)
		label val dv_phy_sex_any_12m yesno
		label var dv_phy_sex_any_12m	"Experienced physical OR sexual violence in the last 12 months"

		//in the last 12 months by frequency (often or sometimes)
		gen dv_phy_sex_any_12m_f = 0 if v044==1 
		replace dv_phy_sex_any_12m_f = 1 if (dv_phy_12m==1 | dv_sex_12m==1)
		replace dv_phy_sex_any_12m_f = 2 if (dv_phy_12m==2 | dv_sex_12m==2)
		label val dv_phy_sex_any_12m_f frequency
		label var dv_phy_sex_any_12m_f	"Experienced physical OR sexual violence in the last 12 months, frequency"

		//which type
		gen dv_viol_type = 0 if dv_phy_sex_any==1
		replace dv_viol_type = 1 if (dv_phy==1 & dv_sex==0)
		replace dv_viol_type = 2 if (dv_phy==0 & dv_sex==1)
		replace dv_viol_type = 3 if (dv_phy==1 & dv_sex==1)
		label define dv_viol_type 1 "physical only" 2 "sexual only" 3 "both"
		label val dv_viol_type dv_viol_type
		label var dv_viol_type	"Ever experienced physical only, sexual only, or both"
	
		//physical only
		gen dv_phy_only = 0 if v044==1
		replace dv_phy_only = 1 if (dv_phy==1 & dv_sex==0)
		label val dv_phy_only yesno
		label var dv_phy_only	"Ever experienced only physical violence"

		//sexual only
		gen dv_sex_only = 0 if v044==1
		replace dv_sex_only = 1 if (dv_phy==0 & dv_sex==1)
		label val dv_sex_only yesno
		label var dv_sex_only	"Ever experienced only sexual violence"
		

/**************************************************************************
*CLONE AND RENAME VARIABLES
**************************************************************************/

* --- Identification and design variables ---
clonevar cluster           = v001
clonevar household         = v002
clonevar respondent_line   = v003
clonevar wt_raw            = v005
clonevar psu               = v021
clonevar strata            = v022
clonevar month_interview   = v006
clonevar year_interview    = v007

* --- Sociodemographic variables ---
clonevar age_w             = v012
clonevar age_group         = v013
clonevar region            = v024
clonevar residence         = v025
clonevar education         = v106
clonevar wealth            = v190
clonevar marital_status    = v501
clonevar religion		   = v130
clonevar tobacco_use       = v463a

* --- Maternal and health variables ---
clonevar children_everborn = v201
clonevar children_living   = v218
clonevar bmi_raw           = v445
clonevar hb_raw            = v437
clonevar anemia_level      = v457

* --- Employment, media exposure, and empowerment ---
clonevar currently_working  = v714
clonevar media_news         = v157
clonevar media_radio        = v158
clonevar media_tv           = v159
clonevar decision_health    = v743a
clonevar decision_largepurch = v743b
clonevar decision_visits    = v743c
clonevar decision_earnings  = v743d
clonevar decision_spending  = v743e
clonevar decision_husband   = v743f

* --- Partner characteristics ---
clonevar partner_education  = v701
clonevar partner_occupation = v705

* --- Reproductive / nutrition status ---
clonevar currently_pregnant  = v213
clonevar currently_breastfeeding = v404

* --- Household composition and food security ---
clonevar hh_size             = v136
clonevar num_children_u5     = v137
clonevar has_bank_account    = v170
clonevar uses_internet       = v171a

* --- Substance use ---
clonevar alcohol_use         = v485a
clonevar husband_alcohol_use = d113



/**************************************************************************
* LABEL CLONED VARIABLES
**************************************************************************/

label var wt                   "Sample weight (normalized)"
label var psu                  "Primary sampling unit"
label var strata               "Sampling strata"
label var age_w                  "Age in years"
label var age_group            "Age group (5-year)"
label var region               "Region of residence"
label var residence            "Type of residence (urban/rural)"
label var education            "Highest education level"
label var wealth               "Wealth index"
label var marital_status       "Current marital status"
label var bmi                  "Body Mass Index (kg/m²)"
label var hb_raw               "Hemoglobin level (g/dL, adjusted)"
label var depression           "Depression symptoms (mth19)"
label var currently_working    "Currently working"
label var media_news           "Reads newspaper"
label var media_radio          "Listens to radio"
label var media_tv             "Watches TV"
label var decision_health      "Decision on own health care"
label var decision_largepurch  "Decision on large household purchases"
label var decision_visits      "Decision on family visits"
label var partner_education    "Partner’s highest education level"
label var partner_occupation   "Partner’s occupation"
label var currently_pregnant   "Currently pregnant"
label var currently_breastfeeding "Currently breastfeeding"
label var hh_size              "Number of household members"
label var num_children_u5      "Number of children under 5"
label var has_bank_account       "Owns a bank account in her name"
label var uses_internet       "Uses internet"
label var tobacco_use          "Currently uses tobacco"
label var alcohol_use          "Currently drinks alcohol"
label var husband_alcohol_use  "Husband drinks alcohol"
label var anemia_level  		"Anemia level"


* Check for missing values
misstable summarize depression 
misstable summarize nt_wm_mdd 
misstable summarize age_cat3 
misstable summarize residence 
misstable summarize education
misstable summarize wealth
misstable summarize currently_working
misstable summarize marital_cat3
misstable summarize currently_pregnant
misstable summarize agefb18
misstable summarize parity_cat
misstable summarize tobacco_use
misstable summarize is_catholic
misstable summarize bmi_cat3
misstable summarize autonomy_proxy
misstable summarize is_catholic



svyset psu [iw=wt_dv], strata(strata) singleunit(centered)


* TABLE 1

svy: tab age_cat3, percent
svy: tab residence, percent
svy: tab education_cat2, percent
svy: tab marital_cat3, percent
svy: tab wealth_cat2, percent
svy: tab currently_working, percent
svy: tab currently_pregnant, percent
svy: tab agefb18, percent
svy: tab parity_cat, percent
svy: tab tobacco_use, percent
svy: tab bmi_cat3, percent
svy: tab autonomy_proxy, percent
svy: tab dv_phy_sex_any, percent
svy: tab depression2, percent
svy: tab anxiety2, percent
svy: tab nt_wm_mdd, percent

* TABLE 2

*Unadjusted Estimates
svyset psu [iw=wt_dv], strata(strata) singleunit(centered)
svy: glm depression2 i.nt_wm_mdd, family(poisson) link(log) eform
svy: glm anxiety2 i.nt_wm_mdd, family(poisson) link(log) eform

* TABLE 2
* both categorical
svyset psu [iw=wt_dv], strata(strata) singleunit(centered)
svy: glm depression2 i.nt_wm_mdd i.dv_phy_sex_any i.age_group i.residence i.education i.wealth i.currently_working i.marital_status i.currently_pregnant ib2.parity_cat i.tobacco_use i.autonomy_proxy i.religion, family(poisson) link(log) eform
svy: glm anxiety2 i.nt_wm_mdd i.dv_phy_sex_any i.age_group i.residence i.education i.wealth i.currently_working i.marital_status i.currently_pregnant ib2.parity_cat i.tobacco_use i.autonomy_proxy i.religion, family(poisson) link(log) eform

* Supplementary Table 2
* outcome continous
svy: regress phq9_total i.nt_wm_mdd i.dv_phy_sex_any i.age_group i.residence i.education i.wealth i.currently_working i.marital_status i.currently_pregnant ib2.parity_cat i.tobacco_use i.autonomy_proxy i.religion
svy: regress gad7_total i.nt_wm_mdd i.dv_phy_sex_any i.age_group i.residence i.education i.wealth i.currently_working i.marital_status i.currently_pregnant ib2.parity_cat i.tobacco_use i.autonomy_proxy i.religion

* Supplementary Table 3
* both continous
svy: regress phq9_total foodsum i.dv_phy_sex_any i.age_group i.residence i.education i.wealth i.currently_working i.marital_status i.currently_pregnant ib2.parity_cat i.tobacco_use i.autonomy_proxy i.religion
svy: regress gad7_total foodsum i.dv_phy_sex_any i.age_group i.residence i.education i.wealth i.currently_working i.marital_status i.currently_pregnant ib2.parity_cat i.tobacco_use i.autonomy_proxy i.religion


* COMBINED
* Combined mild depression or anxiety (PHQ-9 = 10 or GAD-7 = 10)
gen dep_anx = .
replace dep_anx = 1 if depression2 == 1 | anxiety2 == 1
replace dep_anx = 0 if depression2 == 0 & anxiety2 == 0
replace dep_anx = . if missing(depression2) | missing(anxiety2)

label define lbl_dep_anx 0 "No mild depression or anxiety" 1 "Mild depression or anxiety"
label values dep_anx lbl_dep_anx
label var dep_anx "Any moderate-servere depression or anxiety (PHQ-9=10 or GAD-7=10)"

* Prevalence
svyset psu [iw=wt_dv], strata(strata) singleunit(centered)
svy: tab dep_anx, percent
svy: tab dep_anx nt_wm_mdd, percent   // or foodsum categories if preferred

* Unadjusted
svy: glm dep_anx i.nt_wm_mdd, family(poisson) link(log) eform


* Supplementary Table 4
* binary exposure
svy: glm dep_anx i.nt_wm_mdd i.dv_phy_sex_any i.age_group i.residence ///
    i.education i.wealth i.currently_working i.marital_status ///
    i.currently_pregnant ib2.parity_cat i.tobacco_use ///
    i.autonomy_proxy i.religion, family(poisson) link(log) eform

* Supplementary Table 5
* Continous exposure
svy: glm dep_anx foodsum i.dv_phy_sex_any i.age_group i.residence ///
    i.education i.wealth i.currently_working i.marital_status ///
    i.currently_pregnant ib2.parity_cat i.tobacco_use ///
    i.autonomy_proxy i.religion, family(poisson) link(log) eform

