# MicroPython scaffold for an environmental sensor node.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

SENSOR_ID = "field-node-001"

def read_temperature_c():
    return 20.0 + random.random() * 5.0

def build_observation():
    return {
        "source_id": SENSOR_ID,
        "observed_property": "air_temperature",
        "value": round(read_temperature_c(), 2),
        "unit": "degC",
        "quality_flag": "valid",
        "timestamp": time.time()
    }

while True:
    print(build_observation())
    time.sleep(5)
