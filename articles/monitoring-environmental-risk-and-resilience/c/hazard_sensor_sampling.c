#include <stdio.h>

typedef struct {
    const char *sensor_id;
    const char *hazard_type;
    double value;
    double warning_threshold;
    double critical_threshold;
} HazardReading;

int main(void) {
    HazardReading reading = {
        .sensor_id = "haz-heat-001",
        .hazard_type = "heat",
        .value = 106.0,
        .warning_threshold = 100.0,
        .critical_threshold = 110.0
    };

    const char *status = "normal";
    if (reading.value >= reading.critical_threshold) {
        status = "critical";
    } else if (reading.value >= reading.warning_threshold) {
        status = "warning";
    }

    printf("sensor=%s hazard=%s value=%.2f status=%s\n",
           reading.sensor_id, reading.hazard_type, reading.value, status);

    return 0;
}
