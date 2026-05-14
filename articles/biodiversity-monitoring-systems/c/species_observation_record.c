#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *observation_id;
    const char *program_id;
    const char *taxon_group;
    const char *species_or_taxon;
    const char *method_id;
    bool detected;
    const char *effort_units;
    const char *quality_flag;
} SpeciesObservation;

bool requires_review(SpeciesObservation obs) {
    return obs.quality_flag[0] != 'p' || obs.effort_units == NULL;
}

int main(void) {
    SpeciesObservation obs = {
        .observation_id = "obs-001",
        .program_id = "forest-biodiversity-monitoring",
        .taxon_group = "birds",
        .species_or_taxon = "Wood Thrush",
        .method_id = "acoustic_recorder",
        .detected = true,
        .effort_units = "12_hours",
        .quality_flag = "pass"
    };

    printf("observation=%s program=%s taxon=%s species=%s method=%s detected=%s effort=%s review=%s\n",
           obs.observation_id,
           obs.program_id,
           obs.taxon_group,
           obs.species_or_taxon,
           obs.method_id,
           obs.detected ? "true" : "false",
           obs.effort_units,
           requires_review(obs) ? "true" : "false");

    return 0;
}
