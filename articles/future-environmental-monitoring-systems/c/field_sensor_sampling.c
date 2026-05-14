#include <stdio.h>
#include <time.h>

typedef struct {
    const char *sensor_id;
    double value;
    const char *unit;
    const char *quality_flag;
} Observation;

int main(void) {
    Observation obs = {
        .sensor_id = "sensor-water-001",
        .value = 7.42,
        .unit = "pH",
        .quality_flag = "valid"
    };

    printf("sensor_id=%s value=%.2f unit=%s quality=%s\n",
           obs.sensor_id, obs.value, obs.unit, obs.quality_flag);

    return 0;
}
