# MicroPython scaffold for a field node producing platform-ready records.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

SOURCE_ID = "src-water-001"
ASSET_ID = "streamflow-api-001"
DOMAIN = "water"

def read_streamflow_cfs():
    return 1200.0 + random.random() * 900.0

while True:
    value = round(read_streamflow_cfs(), 2)
    print({
        "source_id": SOURCE_ID,
        "asset_id": ASSET_ID,
        "domain": DOMAIN,
        "observed_property": "streamflow",
        "value": value,
        "unit": "cfs",
        "evidence_status": "measured",
        "quality_flag": "simulated",
        "timestamp": time.time()
    })
    time.sleep(5)
