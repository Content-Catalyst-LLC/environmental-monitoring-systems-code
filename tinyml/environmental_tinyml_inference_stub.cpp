#include <stdint.h>
#include <stdio.h>

typedef struct {
    float mean_value;
    float standard_deviation;
    float minimum_value;
    float maximum_value;
    float signal_energy;
    float recent_change_rate;
} EnvironmentalFeatureVector;

float run_environmental_inference_stub(EnvironmentalFeatureVector features) {
    float score = 0.0f;

    score += 0.20f * features.mean_value;
    score += 0.25f * features.standard_deviation;
    score += 0.20f * features.signal_energy;
    score += 0.25f * features.recent_change_rate;

    return score;
}

int main(void) {
    EnvironmentalFeatureVector features = {
        .mean_value = 0.52f,
        .standard_deviation = 0.21f,
        .minimum_value = 0.08f,
        .maximum_value = 0.91f,
        .signal_energy = 0.67f,
        .recent_change_rate = 0.31f
    };

    float anomaly_score = run_environmental_inference_stub(features);

    printf("Environmental TinyML anomaly score: %0.3f\n", anomaly_score);

    return 0;
}
