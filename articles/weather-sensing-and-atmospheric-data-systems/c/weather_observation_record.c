#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *observation_id;
    const char *platform_id;
    const char *variable;
    double value;
    const char *unit;
    const char *qc_flag;
    bool assimilation_eligible;
} WeatherObservationRecord;

bool requires_review(WeatherObservationRecord record) {
    return record.qc_flag[0] != 'p' || !record.assimilation_eligible;
}

int main(void) {
    WeatherObservationRecord record = {
        .observation_id = "obs-001",
        .platform_id = "met-001",
        .variable = "temperature",
        .value = 24.2,
        .unit = "degC",
        .qc_flag = "pass",
        .assimilation_eligible = true
    };

    printf("observation=%s platform=%s variable=%s value=%.2f unit=%s review=%s\n",
           record.observation_id,
           record.platform_id,
           record.variable,
           record.value,
           record.unit,
           requires_review(record) ? "true" : "false");

    return 0;
}
