from __future__ import annotations

import json
import random
from datetime import datetime, timezone


def make_event(sensor_id: str, domain: str) -> dict:
    return {
        "sensor_id": sensor_id,
        "domain": domain,
        "observed_at": datetime.now(timezone.utc).isoformat(),
        "raw_value": round(random.uniform(0.0, 100.0), 3),
        "battery_voltage": round(random.uniform(3.3, 4.1), 3),
        "signal_quality": round(random.uniform(0.70, 1.0), 3),
    }


def main() -> None:
    sensors = [
        ("AIR-001", "air_quality"),
        ("WATER-001", "water_quality"),
        ("SOIL-001", "soil_monitoring"),
    ]

    events = [make_event(sensor_id, domain) for sensor_id, domain in sensors]
    print(json.dumps(events, indent=2))


if __name__ == "__main__":
    main()
