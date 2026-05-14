#include <stdio.h>

typedef struct {
    const char *indicator_id;
    double value;
    const char *unit;
    int quality_flag;
} DashboardReading;

int main(void) {
    DashboardReading reading = {
        .indicator_id = "river-stage-current",
        .value = 18.4,
        .unit = "ft",
        .quality_flag = 1
    };

    printf("indicator=%s value=%.2f unit=%s quality=%d\n",
           reading.indicator_id, reading.value, reading.unit, reading.quality_flag);

    return 0;
}
