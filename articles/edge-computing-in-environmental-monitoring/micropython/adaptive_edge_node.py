# MicroPython scaffold for a low-power environmental edge node.
# Replace simulated readings with hardware-specific sensor drivers and radio transport.

import time
import random

DEVICE_ID = "edge-river-001"
EDGE_RULE_ID = "edge-water-threshold-001"
OBSERVED_PROPERTY = "water_level"
UNIT = "m"
THRESHOLD = 3.2

baseline_interval_seconds = 30
event_interval_seconds = 5

def read_water_level_m():
    return 2.4 + random.random() * 1.2

while True:
    value = round(read_water_level_m(), 3)
    threshold_crossed = value > THRESHOLD
    interval = event_interval_seconds if threshold_crossed else baseline_interval_seconds

    record = {
        "device_id": DEVICE_ID,
        "edge_rule_id": EDGE_RULE_ID,
        "observed_property": OBSERVED_PROPERTY,
        "value": value,
        "unit": UNIT,
        "quality_flag": "threshold_high" if threshold_crossed else "pass",
        "sampling_mode": "event" if threshold_crossed else "baseline",
        "raw_context_retained": threshold_crossed,
        "timestamp": time.time()
    }

    print(record)
    time.sleep(interval)
