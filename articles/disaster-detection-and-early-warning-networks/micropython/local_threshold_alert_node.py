# MicroPython scaffold for a local environmental warning node.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

NODE_ID = "local-warning-node-001"
WARNING_THRESHOLD = 17.0
CRITICAL_THRESHOLD = 20.0

def read_river_stage_ft():
    return 15.0 + random.random() * 7.0

def classify_status(value):
    if value >= CRITICAL_THRESHOLD:
        return "critical"
    if value >= WARNING_THRESHOLD:
        return "warning"
    return "normal"

while True:
    value = round(read_river_stage_ft(), 2)
    print({
        "node_id": NODE_ID,
        "observed_property": "river_stage",
        "value": value,
        "unit": "ft",
        "status": classify_status(value),
        "timestamp": time.time()
    })
    time.sleep(5)
