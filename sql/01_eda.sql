-- Q1: Total customers and overall response rate
-- Result: 381,109 customers | 46,710 responders | 12.3% response rate
SELECT
    COUNT(*) AS total_customers,
    SUM(response) AS responders,
    ROUND(100.0 * SUM(response) / COUNT(*), 1) AS response_rate_pct
FROM customers;

-- Q2: Response rate by vehicle age
-- Result: > 2 Years 29.4% (16,007) | 1-2 Year 17.4% (200,316) | < 1 Year 4.4% (164,786)
SELECT
    vehicle_age,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(response) / COUNT(*), 1) AS response_rate_pct
FROM customers
GROUP BY vehicle_age
ORDER BY response_rate_pct DESC;

-- Q3: Response rate by vehicle damage history
-- Result: Yes 23.8% (192,413) | No 0.5% (188,696)
SELECT
    vehicle_damage,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(response) / COUNT(*), 1) AS response_rate_pct
FROM customers
GROUP BY vehicle_damage
ORDER BY response_rate_pct DESC;

-- Q4: Response rate by prior insurance status
-- Result: previously_insured=0 22.5% (206,481) | previously_insured=1 0.1% (174,628)
SELECT
    previously_insured,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(response) / COUNT(*), 1) AS response_rate_pct
FROM customers
GROUP BY previously_insured
ORDER BY response_rate_pct DESC;

-- Q5: Response rate by age band
-- Result: 20s 4.1% (155,203) | 30s 20.0% (54,253) | 40s 21.2% (76,846) | 50s 17.7% (48,034) | 60+ 10.0% (46,773)
SELECT
    CASE
        WHEN age < 30 THEN '20s'
        WHEN age < 40 THEN '30s'
        WHEN age < 50 THEN '40s'
        WHEN age < 60 THEN '50s'
        ELSE '60+
    END AS age_band,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(response) / COUNT(*), 1) AS response_rate_pct
FROM customers
GROUP BY age_band
ORDER BY age_band;

-- Q6 (bonus): combined signal — no prior insurance + vehicle damage
-- Result: (0, Yes) 25.0% (182,491) | (0, No) 3.8% (23,990) | (1, Yes) 0.9% (9,922) | (1, No) 0.0% (164,706)
SELECT
    previously_insured,
    vehicle_damage,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(response) / COUNT(*), 1) AS response_rate_pct
FROM customers
GROUP BY previously_insured, vehicle_damage
ORDER BY response_rate_pct DESC;