#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *record_id;
    const char *sensor_id;
    const char *parameter;
    double value;
    const char *unit;
    const char *quality_flag;
} WaterSensorRecord;

bool requires_review(WaterSensorRecord record) {
    return record.quality_flag[0] != 'p';
}

int main(void) {
    WaterSensorRecord record = {"obs-001", "wq-001", "turbidity", 6.8, "NTU", "pass"};
    printf("record=%s sensor=%s parameter=%s value=%.2f unit=%s review=%s\n",
           record.record_id, record.sensor_id, record.parameter, record.value, record.unit,
           requires_review(record) ? "true" : "false");
    return 0;
}
