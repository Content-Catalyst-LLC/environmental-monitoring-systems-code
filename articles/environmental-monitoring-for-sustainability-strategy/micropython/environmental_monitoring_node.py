# MicroPython scaffold for a low-power sustainability monitoring node.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

NODE_ID = "sustainability-node-001"
INDICATOR_ID = "water-quality-001"
WARNING_THRESHOLD = 25.0

def read_turbidity_ntu():
    return 10.0 + random.random() * 25.0

def classify_status(value):
    if value >= WARNING_THRESHOLD:
        return "threshold_review"
    return "routine_monitoring"

while True:
    value = round(read_turbidity_ntu(), 2)
    print({
        "node_id": NODE_ID,
        "indicator_id": INDICATOR_ID,
        "observed_property": "turbidity",
        "value": value,
        "unit": "NTU",
        "status": classify_status(value),
        "timestamp": time.time()
    })
    time.sleep(5)
