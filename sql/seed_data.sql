INSERT INTO monitoring_devices VALUES
('ENV-001', 'air_quality_station', 'ESP32', '1.0.0', 'Urban Corridor', 41.8781, -87.6298, '2026-04-01', 1),
('ENV-002', 'water_quality_node', 'STM32', '1.1.0', 'River Reach A', 41.8810, -87.6400, '2026-04-01', 1),
('ENV-003', 'soil_moisture_station', 'RP2040', '0.9.5', 'Research Plot', 41.8900, -87.6500, '2026-04-01', 1);

INSERT INTO environmental_sensors VALUES
('AIR-PM25-001', 'ENV-001', 'pm25', 'air_quality', 'micrograms_per_cubic_meter', 300),
('WATER-PH-001', 'ENV-002', 'ph', 'water_quality', 'ph_units', 300),
('SOIL-MOIST-001', 'ENV-003', 'soil_moisture', 'soil_monitoring', 'percent', 900);

INSERT INTO calibration_records
(sensor_id, calibrated_at, calibration_method, scale_factor, offset_value, reference_standard)
VALUES
('AIR-PM25-001', '2026-03-20', 'co_location_reference', 1.00, 0.00, 'reference_monitor'),
('WATER-PH-001', '2026-03-21', 'buffer_solution_reference', 1.02, -0.05, 'ph_buffer'),
('SOIL-MOIST-001', '2026-03-22', 'gravimetric_reference', 0.98, 0.20, 'lab_reference');

INSERT INTO environmental_observations
(sensor_id, observed_at, raw_value, calibrated_value, battery_voltage, signal_quality, quality_flag, transmitted)
VALUES
('AIR-PM25-001', '2026-04-01T10:00:00', 18.4, 18.4, 3.91, 0.98, 'valid', 1),
('AIR-PM25-001', '2026-04-01T10:05:00', 22.7, 22.7, 3.90, 0.97, 'valid', 1),
('WATER-PH-001', '2026-04-01T10:00:00', 7.10, 7.19, 3.70, 0.91, 'valid', 1),
('SOIL-MOIST-001', '2026-04-01T10:00:00', 34.20, 33.72, 3.50, 0.76, 'low_signal_quality', 0);
