# Field Data Integrity Notes

Embedded device data integrity depends on the whole field chain.

## Device questions

- Is the device alive?
- Is it powered with enough margin?
- Is storage healthy?
- Is telemetry working?
- Is the clock stable?
- Is firmware versioned?
- Is the enclosure dry, intact, and properly mounted?
- Is calibration current?

## Measurement questions

- What environmental property is actually observed?
- What unit is used?
- Is the sensor suitable for the field environment?
- Is the device measuring the target process directly or a proxy?
- Are values raw, corrected, filtered, summarized, or inferred?

## Integrity questions

- Are missing records visible?
- Are delayed records marked?
- Are suspect values flagged?
- Are range, spike, flatline, and drift checks applied?
- Can device anomaly be distinguished from environmental anomaly?
- Can public claims be traced back to device, calibration, firmware, and field context?
