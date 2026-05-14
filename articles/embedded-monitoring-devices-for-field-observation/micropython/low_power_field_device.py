# MicroPython scaffold for a low-power embedded environmental monitoring device.
# Replace simulated readings with hardware-specific sensor, storage, and telemetry drivers.

import time
import random

DEVICE_ID = "river-stage-logger-001"
OBSERVED_PROPERTY = "water_level"
UNIT = "m"
FIRMWARE_VERSION = "v1.4.2"
CALIBRATION_STATUS = "valid"

BASELINE_INTERVAL_SECONDS = 30
EVENT_INTERVAL_SECONDS = 5
ALERT_THRESHOLD = 3.2

def read_water_level_m():
    return 2.4 + random.random() * 1.2

def read_battery_voltage():
    return 12.0 + random.random() * 0.7

while True:
    value = round(read_water_level_m(), 3)
    battery = round(read_battery_voltage(), 2)
    threshold_high = value >= ALERT_THRESHOLD

    record = {
        "device_id": DEVICE_ID,
        "observed_property": OBSERVED_PROPERTY,
        "value": value,
        "unit": UNIT,
        "quality_flag": "threshold_high" if threshold_high else "pass",
        "calibration_status": CALIBRATION_STATUS,
        "firmware_version": FIRMWARE_VERSION,
        "battery_voltage": battery,
        "phenomenon_time": time.time()
    }

    print(record)
    time.sleep(EVENT_INTERVAL_SECONDS if threshold_high else BASELINE_INTERVAL_SECONDS)
