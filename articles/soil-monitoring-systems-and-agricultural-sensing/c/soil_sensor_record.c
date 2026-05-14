#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *record_id;
    const char *sensor_id;
    const char *parameter;
    double value;
    const char *unit;
    const char *quality_flag;
} SoilSensorRecord;

bool requires_review(SoilSensorRecord record) {
    return record.quality_flag[0] != 'p';
}

int main(void) {
    SoilSensorRecord record = {"rec-001", "sm-001", "volumetric_water_content", 0.24, "m3_m3", "pass"};
    printf("record=%s sensor=%s parameter=%s value=%.2f unit=%s review=%s\n",
           record.record_id, record.sensor_id, record.parameter, record.value, record.unit,
           requires_review(record) ? "true" : "false");
    return 0;
}
