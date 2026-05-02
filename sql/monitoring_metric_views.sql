CREATE VIEW IF NOT EXISTS environmental_monitoring_summary AS
SELECT
    s.sensor_id,
    s.sensor_type,
    s.environmental_domain,
    d.device_id,
    d.deployment_site,
    COUNT(o.observation_id) AS observation_count,
    AVG(o.calibrated_value) AS mean_calibrated_value,
    AVG(o.battery_voltage) AS mean_battery_voltage,
    AVG(o.signal_quality) AS mean_signal_quality
FROM environmental_sensors s
JOIN monitoring_devices d ON s.device_id = d.device_id
LEFT JOIN environmental_observations o ON s.sensor_id = o.sensor_id
GROUP BY
    s.sensor_id,
    s.sensor_type,
    s.environmental_domain,
    d.device_id,
    d.deployment_site;
