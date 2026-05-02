-- Environmental quality checks

SELECT *
FROM environmental_observations
WHERE battery_voltage IS NULL
   OR battery_voltage < 3.3;

SELECT *
FROM environmental_observations
WHERE signal_quality IS NULL
   OR signal_quality < 0.80;

SELECT
    sensor_id,
    COUNT(*) AS observation_count,
    AVG(CASE WHEN quality_flag = 'valid' THEN 1.0 ELSE 0.0 END) AS valid_record_rate,
    AVG(signal_quality) AS mean_signal_quality,
    AVG(battery_voltage) AS mean_battery_voltage
FROM environmental_observations
GROUP BY sensor_id;
