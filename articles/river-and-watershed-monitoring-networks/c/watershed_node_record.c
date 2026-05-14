#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *node_id;
    const char *station_id;
    const char *site_type;
    const char *basin_position;
    double upstream_area_km2;
    const char *telemetry_status;
} WatershedNodeRecord;

bool requires_review(WatershedNodeRecord record) {
    return record.telemetry_status[0] != 'a';
}

int main(void) {
    WatershedNodeRecord record = {
        .node_id = "tributary-a",
        .station_id = "st-002",
        .site_type = "streamgage_water_quality",
        .basin_position = "tributary",
        .upstream_area_km2 = 120.0,
        .telemetry_status = "active"
    };

    printf("node=%s station=%s type=%s position=%s area=%.1f review=%s\n",
           record.node_id,
           record.station_id,
           record.site_type,
           record.basin_position,
           record.upstream_area_km2,
           requires_review(record) ? "true" : "false");

    return 0;
}
