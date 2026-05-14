#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *node_id;
    const char *network_id;
    const char *observed_property;
    double value;
    const char *unit;
    const char *quality_flag;
    const char *calibration_status;
} NetworkObservation;

bool review_required(NetworkObservation obs) {
    return obs.quality_flag[0] != 'p' || obs.calibration_status[0] != 'v';
}

int main(void) {
    NetworkObservation obs = {
        .node_id = "node-river-001",
        .network_id = "river-watershed-network",
        .observed_property = "water_level",
        .value = 2.74,
        .unit = "m",
        .quality_flag = "pass",
        .calibration_status = "valid"
    };

    printf("node=%s network=%s property=%s value=%.2f unit=%s quality=%s calibration=%s review=%s\n",
           obs.node_id,
           obs.network_id,
           obs.observed_property,
           obs.value,
           obs.unit,
           obs.quality_flag,
           obs.calibration_status,
           review_required(obs) ? "true" : "false");

    return 0;
}
