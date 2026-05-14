# MicroPython scaffold for a field node feeding a dashboard indicator.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

NODE_ID = "dashboard-field-node-001"
INDICATOR_ID = "river-stage-current"
WARNING_THRESHOLD = 17.0

def read_river_stage_ft():
    return 14.0 + random.random() * 6.0

def status(value):
    return "warning" if value >= WARNING_THRESHOLD else "normal"

while True:
    value = round(read_river_stage_ft(), 2)
    print({
        "node_id": NODE_ID,
        "indicator_id": INDICATOR_ID,
        "value": value,
        "unit": "ft",
        "status": status(value),
        "evidence_type": "measured",
        "timestamp": time.time()
    })
    time.sleep(5)
