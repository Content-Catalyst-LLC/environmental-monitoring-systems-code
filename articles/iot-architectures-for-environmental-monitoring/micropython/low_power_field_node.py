# MicroPython scaffold for a low-power environmental IoT field node.
# Replace simulated readings with hardware-specific sensor drivers and radio transport.

import time
import random

DEVICE_ID = "river-node-001"
OBSERVED_PROPERTY = "water_level"
UNIT = "m"
CALIBRATION_STATUS = "valid"

def read_water_level_m():
    return 2.2 + random.random() * 1.2

while True:
    value = round(read_water_level_m(), 3)
    record = {
        "device_id": DEVICE_ID,
        "observed_property": OBSERVED_PROPERTY,
        "value": value,
        "unit": UNIT,
        "phenomenon_time": time.time(),
        "quality_flag": "pass" if value < 3.2 else "threshold_high",
        "calibration_status": CALIBRATION_STATUS,
        "edge_rule_id": "edge-water-range-001"
    }
    print(record)
    time.sleep(10)
