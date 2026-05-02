from __future__ import annotations

import sqlite3
from pathlib import Path

import pandas as pd


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data" / "processed"
OUTPUT_DIR = PROJECT_ROOT / "outputs" / "tables"
DATABASE_PATH = PROJECT_ROOT / "outputs" / "environmental_monitoring.sqlite"

DATA_DIR.mkdir(parents=True, exist_ok=True)
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
DATABASE_PATH.parent.mkdir(parents=True, exist_ok=True)


def create_synthetic_observations() -> pd.DataFrame:
    return pd.DataFrame(
        [
            {"sensor_id": "AIR-001", "domain": "air_quality", "raw_value": 18.4, "scale_factor": 1.00, "offset_value": 0.00, "battery_voltage": 3.91, "signal_quality": 0.98, "observed_at": "2026-04-01T10:00:00"},
            {"sensor_id": "AIR-001", "domain": "air_quality", "raw_value": 22.7, "scale_factor": 1.00, "offset_value": 0.00, "battery_voltage": 3.90, "signal_quality": 0.97, "observed_at": "2026-04-01T10:05:00"},
            {"sensor_id": "WATER-001", "domain": "water_quality", "raw_value": 7.10, "scale_factor": 1.02, "offset_value": -0.05, "battery_voltage": 3.70, "signal_quality": 0.91, "observed_at": "2026-04-01T10:00:00"},
            {"sensor_id": "SOIL-001", "domain": "soil_monitoring", "raw_value": 34.20, "scale_factor": 0.98, "offset_value": 0.20, "battery_voltage": 3.50, "signal_quality": 0.76, "observed_at": "2026-04-01T10:00:00"},
            {"sensor_id": "ECO-001", "domain": "biodiversity", "raw_value": None, "scale_factor": 1.00, "offset_value": 0.00, "battery_voltage": 3.66, "signal_quality": 0.88, "observed_at": "2026-04-01T10:00:00"},
        ]
    )


def add_calibrated_values(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["calibrated_value"] = (df["scale_factor"] * df["raw_value"]) + df["offset_value"]
    return df


def calculate_quality_report(df: pd.DataFrame) -> pd.DataFrame:
    valid_records = (
        df["calibrated_value"].notna()
        & (df["battery_voltage"] >= 3.3)
        & (df["signal_quality"] >= 0.80)
    )

    return pd.DataFrame(
        [
            {
                "record_count": len(df),
                "missing_raw_values": int(df["raw_value"].isna().sum()),
                "mean_battery_voltage": float(df["battery_voltage"].mean()),
                "mean_signal_quality": float(df["signal_quality"].mean()),
                "valid_records": int(valid_records.sum()),
                "valid_record_rate": float(valid_records.mean()),
            }
        ]
    )


def main() -> None:
    observations = create_synthetic_observations()
    observations["observed_at"] = pd.to_datetime(observations["observed_at"])
    observations = add_calibrated_values(observations)

    quality_report = calculate_quality_report(observations)

    observations_path = DATA_DIR / "environmental_observations.csv"
    report_path = OUTPUT_DIR / "environmental_telemetry_quality_report.csv"

    observations.to_csv(observations_path, index=False)
    quality_report.to_csv(report_path, index=False)

    with sqlite3.connect(DATABASE_PATH) as connection:
        observations.to_sql("environmental_observations", connection, if_exists="replace", index=False)
        quality_report.to_sql("environmental_telemetry_quality_report", connection, if_exists="replace", index=False)

    print("Environmental Telemetry Quality Pipeline complete.")
    print(quality_report)


if __name__ == "__main__":
    main()
