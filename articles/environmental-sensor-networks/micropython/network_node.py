# MicroPython scaffold for a low-power environmental sensor-network node.
# Replace simulated readings with hardware-specific sensor, storage, and telemetry drivers.

import time
import random

NODE_ID = "node-river-001"
NETWORK_ID = "river-watershed-network"
OBSERVED_PROPERTY = "water_level"
UNIT = "m"
CALIBRATION_STATUS = "valid"

def read_water_level_m():
    return 2.4 + random.random() * 1.2

while True:
    value = round(read_water_level_m(), 3)
    record = {
        "node_id": NODE_ID,
        "network_id": NETWORK_ID,
        "observed_property": OBSERVED_PROPERTY,
        "value": value,
        "unit": UNIT,
        "quality_flag": "pass" if value < 3.2 else "threshold_high",
        "calibration_status": CALIBRATION_STATUS,
        "phenomenon_time": time.time()
    }
    print(record)
    time.sleep(30)
