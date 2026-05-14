#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *device_id;
    const char *observed_property;
    double value;
    const char *unit;
    const char *quality_flag;
    const char *calibration_status;
    const char *firmware_version;
    double battery_voltage;
} FieldObservation;

bool is_review_required(FieldObservation obs) {
    return obs.battery_voltage < 3.3 ||
           obs.quality_flag[0] != 'p' ||
           obs.calibration_status[0] != 'v';
}

int main(void) {
    FieldObservation obs = {
        .device_id = "river-stage-logger-001",
        .observed_property = "water_level",
        .value = 2.74,
        .unit = "m",
        .quality_flag = "pass",
        .calibration_status = "valid",
        .firmware_version = "v1.4.2",
        .battery_voltage = 12.4
    };

    printf("device=%s property=%s value=%.2f unit=%s quality=%s calibration=%s firmware=%s battery=%.2f review=%s\n",
           obs.device_id,
           obs.observed_property,
           obs.value,
           obs.unit,
           obs.quality_flag,
           obs.calibration_status,
           obs.firmware_version,
           obs.battery_voltage,
           is_review_required(obs) ? "true" : "false");

    return 0;
}
