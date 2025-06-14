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

-- 4. a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs. **Hint:** You may want to use a CASE expression for this. See https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-case/ 

--     b. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.

-- SELECT drug_name, 
-- CASE 
-- 		WHEN opioid_drug_flag = 'Y' THEN 'opioid'
-- 		WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
-- 		ELSE 'neither'
-- END drug_type 
-- FROM drug; 

--ANSWER:3425 row

-- SELECT  SUM(total_drug_cost) as sum_of_drug_cost,
-- CASE 
-- 		WHEN opioid_drug_flag = 'Y' THEN 'opioid'
-- 		WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
-- 		ELSE 'neither'
-- END drug_type 
-- FROM drug
-- LEFT JOIN prescription
-- USING (drug_name)
-- GROUP BY drug_type; 

-- select prescription.drug_name, SUM(total_drug_cost) as sum_of_drug_cost
-- from prescription;

--ANSWER: More money was spent on 105080626.37	"opioid"


-- 5. 
--     a. How many CBSAs are in Tennessee? **Warning:** The cbsa table contains information for all states, not just Tennessee.

--     b. Which cbsa has the largest combined population? Which has the smallest? Report the CBSA name and total population.

--     c. What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population.

-- SELECT * --COUNT(cbsa)
-- FROM cbsa
-- WHERE cbsaname LIKE '%, TN%';
-- --There are 56 CBSA's in Tennessee

-- SELECT cbsaname, SUM(population) AS total_pop
-- FROM cbsa
-- LEFT JOIN population
-- USING (fipscounty)
-- WHERE population IS NOT NULL
-- GROUP BY cbsaname
-- ORDER BY total_pop DESC
-- LIMIT 1;

-- LARGEST: "Nashville-Davidson--Murfreesboro--Franklin, TN"	1830410

-- SELECT cbsaname, SUM(population) AS total_pop
-- FROM cbsa
-- LEFT JOIN population
-- USING (fipscounty)
-- WHERE population IS NOT NULL
-- GROUP BY cbsaname
-- ORDER BY total_pop
-- LIMIT 1;

-- SMALLEST:
-- "Morristown, TN"	116352

-- SELECT cbsaname, SUM(population) AS total_pop
-- FROM cbsa
-- LEFT JOIN population
-- USING (fipscounty)
-- WHERE population
-- GROUP BY cbsaname
-- ORDER BY total_pop
-- LIMIT 1;

-- SELECT fips_county.county, population 
-- FROM population
-- LEFT JOIN fips_county
-- USING (fipscounty)
-- LEFT JOIN cbsa
-- USING (fipscounty)
-- WHERE cbsa IS NULL
-- ORDER BY population DESC
-- LIMIT 1;
-- 6. 
--     a. Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name and the total_claim_count.

--     b. For each instance that you found in part a, add a column that indicates whether the drug is an opioid.

--     c. Add another column to you answer from the previous part which gives the prescriber first and last name associated with each row.

-- SELECT npi, drug_name, total_claim_count
-- FROM prescription
-- WHERE total_claim_count >=3000;

