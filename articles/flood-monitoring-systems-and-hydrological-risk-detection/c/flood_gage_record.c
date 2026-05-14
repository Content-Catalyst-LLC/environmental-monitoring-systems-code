#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *record_id;
    const char *station_id;
    const char *observed_variable;
    double value;
    const char *unit;
    const char *quality_flag;
} FloodGageRecord;

bool requires_review(FloodGageRecord record) {
    return record.quality_flag[0] != 'p';
}

int main(void) {
    FloodGageRecord record = {
        .record_id = "obs-001",
        .station_id = "gage-001",
        .observed_variable = "stage_ft",
        .value = 19.4,
        .unit = "ft",
        .quality_flag = "pass"
    };

    printf("record=%s station=%s variable=%s value=%.2f unit=%s review=%s\n",
           record.record_id,
           record.station_id,
           record.observed_variable,
           record.value,
           record.unit,
           requires_review(record) ? "true" : "false");

    return 0;
}
