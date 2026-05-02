from __future__ import annotations

import numpy as np


def extract_environmental_features(values: np.ndarray) -> dict:
    values = np.asarray(values, dtype=float)
    centered = values - np.mean(values)

    return {
        "mean_value": float(np.mean(values)),
        "standard_deviation": float(np.std(values)),
        "minimum_value": float(np.min(values)),
        "maximum_value": float(np.max(values)),
        "signal_energy": float(np.sum(values ** 2)),
        "recent_change_rate": float(values[-1] - values[0]) / max(len(values), 1),
        "zero_crossing_rate": float(np.sum(np.diff(np.signbit(centered)))) / max(len(values), 1),
    }


def main() -> None:
    rng = np.random.default_rng(seed=42)
    values = rng.normal(loc=20.0, scale=1.5, size=128)
    print(extract_environmental_features(values))


if __name__ == "__main__":
    main()
