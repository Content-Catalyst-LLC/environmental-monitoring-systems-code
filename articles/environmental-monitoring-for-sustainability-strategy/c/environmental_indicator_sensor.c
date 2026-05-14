#include <stdio.h>

typedef struct {
    const char *sensor_id;
    const char *indicator_id;
    double value;
    const char *unit;
    double threshold;
} IndicatorReading;

int main(void) {
    IndicatorReading reading = {
        .sensor_id = "air-quality-node-001",
        .indicator_id = "air-quality-exposure-001",
        .value = 38.0,
        .unit = "ug_m3",
        .threshold = 35.0
    };

    const char *status = reading.value > reading.threshold ? "threshold_review" : "routine_monitoring";

    printf("sensor=%s indicator=%s value=%.2f unit=%s status=%s\n",
           reading.sensor_id, reading.indicator_id, reading.value, reading.unit, status);

    return 0;
}
