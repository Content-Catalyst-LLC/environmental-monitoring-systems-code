from __future__ import annotations

import math
from pathlib import Path

import pandas as pd


PROJECT_ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = PROJECT_ROOT / "outputs" / "tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def haversine_km(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    radius_km = 6371.0

    phi1 = math.radians(lat1)
    phi2 = math.radians(lat2)
    delta_phi = math.radians(lat2 - lat1)
    delta_lambda = math.radians(lon2 - lon1)

    a = (
        math.sin(delta_phi / 2) ** 2
        + math.cos(phi1) * math.cos(phi2) * math.sin(delta_lambda / 2) ** 2
    )

    return 2 * radius_km * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def main() -> None:
    sites = pd.DataFrame(
        [
            {"site_id": "SITE-001", "lat": 41.8781, "lon": -87.6298},
            {"site_id": "SITE-002", "lat": 41.8810, "lon": -87.6400},
            {"site_id": "SITE-003", "lat": 41.8900, "lon": -87.6500},
        ]
    )

    reference = sites.iloc[0]

    sites["distance_from_reference_km"] = sites.apply(
        lambda row: haversine_km(reference["lat"], reference["lon"], row["lat"], row["lon"]),
        axis=1,
    )

    sites.to_csv(OUTPUT_DIR / "site_distance_summary.csv", index=False)
    print(sites)


if __name__ == "__main__":
    main()
