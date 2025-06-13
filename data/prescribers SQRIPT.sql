--1.a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.

--1.b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, and the total number of claims.

-- SELECT npi, SUM(total_claim_count) as sum_claim_count
-- FROM prescription
-- LEFT JOIN prescriber
-- USING (npi)
-- GROUP BY npi
-- ORDER BY sum_claim_count DESC
-- LIMIT 1;
--ANSWER: 1a. npi=1881634483, sum_claim_count=99707


-- SELECT npi, nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, SUM(total_claim_count) as sum_claim_count
-- FROM prescription
-- LEFT JOIN prescriber
-- USING (npi)
-- GROUP BY npi,nppes_provider_first_name, nppes_provider_last_org_name, specialty_description
-- ORDER BY sum_claim_count DESC
-- LIMIT 1;
---ANSWER 1b. 1881634483 "BRUCE" "PENDLEY" "Family Practice"	99707


--2.a. Which specialty had the most total number of claims (totaled over all drugs)?

--2.b. Which specialty had the most total number of claims for opioids?

-- SELECT  specialty_description, SUM(total_claim_count) as sum_claim_count
-- FROM prescription
-- LEFT JOIN prescriber
-- USING (npi)
-- GROUP BY specialty_description
-- ORDER BY sum_claim_count DESC;
 --ANSWER 2a. "Family Practice"	9752347

-- SELECT specialty_description,  SUM(total_claim_count) as sum_claim_count
-- FROM prescription
-- LEFT JOIN prescriber
-- USING (npi)
-- LEFT JOIN drug
-- USING (drug_name)
-- WHERE opioid_drug_flag = 'Y'
-- GROUP BY specialty_description
-- ORDER BY sum_claim_count DESC
-- LIMIT 1;
--ANSWER 2b. "Nurse Practitioner"	900845

--3. a. Which drug (generic_name) had the highest total drug cost?

--3. b. Which drug (generic_name) has the hightest total cost per day? Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.

-- SELECT generic_name, sum(total_drug_cost) as sum_drug_cost
-- FROM prescription
-- LEFT JOIN drug
-- USING (drug_name)
-- GROUP BY generic_name
-- ORDER BY sum_drug_cost DESC
-- LIMIT 1;

--ANSWER 3a. "INSULIN GLARGINE,HUM.REC.ANLOG"	104264066.35

-- SELECT generic_name, ROUND(sum(total_drug_cost/total_day_supply),2) as drug_cost_perday
-- FROM prescription
-- LEFT JOIN drug
-- USING (drug_name)
-- GROUP BY generic_name
-- ORDER BY drug_cost_perday DESC
-- LIMIT 1;

--ANSWER 3b. "LEDIPASVIR/SOFOSBUVIR"	88270.87



