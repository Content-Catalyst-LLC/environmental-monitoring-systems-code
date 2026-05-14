#include <stdio.h>

typedef struct {
    const char *device_id;
    const char *observed_property;
    double value;
    const char *unit;
    const char *quality_flag;
    const char *calibration_status;
} EnvironmentalObservation;

int main(void) {
    EnvironmentalObservation obs = {"river-node-001", "water_level", 2.74, "m", "pass", "valid"};
    printf("device=%s property=%s value=%.2f unit=%s quality=%s calibration=%s\n",
           obs.device_id, obs.observed_property, obs.value, obs.unit, obs.quality_flag, obs.calibration_status);
    return 0;
}
