# MicroPython scaffold for a low-power field validation node.
# Replace simulated readings with hardware-specific sensor drivers.

import time
import random

STATION_ID = "field-validation-node-001"
LINKED_PRODUCT_ID = "sentinel-sar-flood-extent"
DOMAIN = "flood"

def read_surface_water_presence():
    return 1 if random.random() > 0.45 else 0

while True:
    value = read_surface_water_presence()
    print({
        "station_id": STATION_ID,
        "linked_product_id": LINKED_PRODUCT_ID,
        "domain": DOMAIN,
        "observed_property": "surface_water_presence",
        "value": value,
        "unit": "binary",
        "evidence_status": "field_validation",
        "quality_flag": "simulated",
        "timestamp": time.time()
    })
    time.sleep(5)
