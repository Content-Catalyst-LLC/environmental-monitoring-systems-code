#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *site_id;
    const char *parameter_id;
    double value;
    const char *unit;
    const char *method_type;
    const char *quality_flag;
} WaterQualitySensorRecord;

bool requires_review(WaterQualitySensorRecord record) {
    return record.quality_flag[0] != 'p';
}

int main(void) {
    WaterQualitySensorRecord record = {
        .site_id = "wq-001",
        .parameter_id = "do",
        .value = 7.4,
        .unit = "mg_L",
        .method_type = "field_sensor",
        .quality_flag = "pass"
    };

    printf("site=%s parameter=%s value=%.2f unit=%s method=%s review=%s\n",
           record.site_id,
           record.parameter_id,
           record.value,
           record.unit,
           record.method_type,
           requires_review(record) ? "true" : "false");

    return 0;
}
