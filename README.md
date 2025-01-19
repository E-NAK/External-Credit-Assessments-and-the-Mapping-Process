# External-Credit-Assessments-and-the-Mapping-Process
# Background Information
The Office of the Superintendent of Financial Institutions (OSFI) has raised a new set of
requirements to direct the usage of external credit assessments by big banks. After a review
process of the major international rating agencies, OSFI has permitted banks to recognize credit
ratings from the following rating agencies for capital adequacy purposes.
• DBRS
• Moody’s Investors Service
• Standard and Poor’s (S&P)
• Fitch Rating Services
Each bank will be responsible for assigning eligible External Credit Assessment Institutions
(ECAIs)’ Assessments of the risk weights are available under the standardized risk weighting
framework, i.e., deciding which assessment categories correspond to which risk weights. The
mapping process should be objective and should result in a risk weight assignment consistent
with that of the level of credit risk reflected in the tables above. It should cover the full spectrum of risk 
weights. The following table guides as to how such a mapping process may be conducted:

![image](https://github.com/user-attachments/assets/6687a97d-7c17-4549-a965-727be40c6669)

# Rules:
• If there is only one assessment by an ECAI chosen by a bank for a particular claim, that
assessment should be used to determine the risk weight of the claim.

• If there are two assessments by ECAIs chosen by a bank which map into different risk weights,
the higher risk weight will be applied.

• If there are three or more assessments with different risk weights, the assessments
corresponding to the two lowest risk weights should be referred to and the higher of those two
risk weights will be applied.

• For the instrument issued by US or Canadian government, if no external rating is available,
default the grade to 'AAA'.

• For the instrument issued by other foreign governments, if no external rating is available,
default the grade to ‘A'.

# Objectives:
For each security issuer, derive the "standardized risk weighting" from the ratings provided by
ECAIs, are based on OSFI's specific rules.

# Inputs:
The inputs provided are:
✓ All the fixed-income securities the bank holds as of Jan 2020. ("bond_jan_2020.csv")

✓ Mapping table from external rating to internal rating. (“lt_rating_to_ig.csv”)

✓ Mapping table from internal rating to grade. (“ig_to_rating.csv”)

Note: item #2 and #3 are derived from the above-mentioned OSFI's guidance.
