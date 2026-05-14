#include <stdio.h>

typedef struct {
    const char *station_id;
    const char *linked_product_id;
    const char *domain;
    double observed_value;
    const char *unit;
    int quality_flag;
} FieldValidationRecord;

int main(void) {
    FieldValidationRecord record = {
        .station_id = "field-validation-node-001",
        .linked_product_id = "sentinel-sar-flood-extent",
        .domain = "flood",
        .observed_value = 1.0,
        .unit = "water_presence_binary",
        .quality_flag = 1
    };

    printf("station=%s product=%s domain=%s observed=%.2f unit=%s quality=%d\n",
           record.station_id,
           record.linked_product_id,
           record.domain,
           record.observed_value,
           record.unit,
           record.quality_flag);

    return 0;
}
