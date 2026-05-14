#include <stdio.h>

typedef struct {
    const char *station_id;
    const char *linked_product_id;
    const char *domain;
    double observed_value;
    const char *unit;
    int quality_flag;
} GroundValidationRecord;

int main(void) {
    GroundValidationRecord record = {
        .station_id = "ground-water-validate-001",
        .linked_product_id = "sentinel-flood-extent",
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
