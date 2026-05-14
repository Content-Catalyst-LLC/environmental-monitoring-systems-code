#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *observation_id;
    const char *sensor_id;
    const char *pollutant;
    double value;
    const char *unit;
    const char *qc_flag;
    const char *calibration_status;
} PollutantObservationRecord;

bool requires_review(PollutantObservationRecord record) {
    return record.qc_flag[0] != 'p' || record.calibration_status[0] == 'e';
}

int main(void) {
    PollutantObservationRecord record = {
        .observation_id = "obs-001",
        .sensor_id = "aq-001",
        .pollutant = "PM2.5",
        .value = 11.4,
        .unit = "ug_m3",
        .qc_flag = "pass",
        .calibration_status = "current"
    };

    printf("observation=%s sensor=%s pollutant=%s value=%.2f unit=%s review=%s\n",
           record.observation_id,
           record.sensor_id,
           record.pollutant,
           record.value,
           record.unit,
           requires_review(record) ? "true" : "false");

    return 0;
}
