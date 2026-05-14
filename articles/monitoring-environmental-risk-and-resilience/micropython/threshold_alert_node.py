# MicroPython scaffold for a local threshold alert node.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

NODE_ID = "threshold-node-001"
WARNING_THRESHOLD = 100.0
CRITICAL_THRESHOLD = 110.0

def read_heat_index():
    return 95.0 + random.random() * 20.0

def classify_status(value):
    if value >= CRITICAL_THRESHOLD:
        return "critical"
    if value >= WARNING_THRESHOLD:
        return "warning"
    return "normal"

while True:
    value = round(read_heat_index(), 2)
    print({
        "node_id": NODE_ID,
        "observed_property": "heat_index",
        "value": value,
        "unit": "degF",
        "status": classify_status(value),
        "timestamp": time.time()
    })
    time.sleep(5)
