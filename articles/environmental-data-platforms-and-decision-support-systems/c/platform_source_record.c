#include <stdio.h>

typedef struct {
    const char *source_id;
    const char *asset_id;
    const char *domain;
    double value;
    const char *unit;
    int quality_flag;
} PlatformSourceRecord;

int main(void) {
    PlatformSourceRecord record = {
        .source_id = "src-water-001",
        .asset_id = "streamflow-api-001",
        .domain = "water",
        .value = 1840.0,
        .unit = "cfs",
        .quality_flag = 1
    };

    printf("source=%s asset=%s domain=%s value=%.2f unit=%s quality=%d\n",
           record.source_id,
           record.asset_id,
           record.domain,
           record.value,
           record.unit,
           record.quality_flag);

    return 0;
}
