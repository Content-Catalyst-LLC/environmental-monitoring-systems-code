#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *observation_id;
    const char *platform_id;
    const char *domain;
    const char *climate_variable;
    double value;
    const char *unit;
    const char *qc_flag;
} ClimateObservationRecord;

bool requires_review(ClimateObservationRecord record) {
    return record.qc_flag[0] != 'p';
}

int main(void) {
    ClimateObservationRecord record = {
        .observation_id = "obs-001",
        .platform_id = "clim-001",
        .domain = "atmosphere",
        .climate_variable = "surface_temperature",
        .value = 2.1,
        .unit = "degC",
        .qc_flag = "pass"
    };

    printf("observation=%s platform=%s domain=%s variable=%s value=%.2f unit=%s review=%s\n",
           record.observation_id,
           record.platform_id,
           record.domain,
           record.climate_variable,
           record.value,
           record.unit,
           requires_review(record) ? "true" : "false");

    return 0;
}
