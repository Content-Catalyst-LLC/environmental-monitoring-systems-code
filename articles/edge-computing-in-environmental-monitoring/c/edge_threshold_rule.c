#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *component_id;
    const char *edge_rule_id;
    const char *observed_property;
    double value;
    const char *unit;
    double threshold;
    const char *quality_flag;
} EdgeObservation;

bool threshold_crossed(EdgeObservation obs) {
    return obs.value > obs.threshold;
}

int main(void) {
    EdgeObservation obs = {
        .component_id = "flood-threshold-gateway",
        .edge_rule_id = "edge-water-threshold-001",
        .observed_property = "water_level",
        .value = 3.35,
        .unit = "m",
        .threshold = 3.20,
        .quality_flag = "pass"
    };

    printf("component=%s rule=%s property=%s value=%.2f unit=%s threshold=%.2f quality=%s crossed=%s\n",
           obs.component_id,
           obs.edge_rule_id,
           obs.observed_property,
           obs.value,
           obs.unit,
           obs.threshold,
           obs.quality_flag,
           threshold_crossed(obs) ? "true" : "false");

    return 0;
}
