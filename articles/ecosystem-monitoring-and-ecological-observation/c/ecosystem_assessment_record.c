#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *assessment_id;
    const char *program_id;
    const char *ecosystem_type;
    double condition_score;
    double structure_score;
    double function_score;
    double integrity_score;
    double resilience_score;
    double confidence;
    bool approved;
} EcosystemAssessment;

bool requires_review(EcosystemAssessment assessment) {
    return !assessment.approved ||
           assessment.confidence < 0.75 ||
           assessment.condition_score < 0.75 ||
           assessment.function_score < 0.70 ||
           assessment.integrity_score < 0.70 ||
           assessment.resilience_score < 0.70;
}

int main(void) {
    EcosystemAssessment assessment = {
        .assessment_id = "assess-001",
        .program_id = "wetland-integrity-monitoring",
        .ecosystem_type = "wetland",
        .condition_score = 0.78,
        .structure_score = 0.74,
        .function_score = 0.72,
        .integrity_score = 0.76,
        .resilience_score = 0.70,
        .confidence = 0.78,
        .approved = true
    };

    printf("assessment=%s program=%s ecosystem=%s condition=%.2f function=%.2f integrity=%.2f resilience=%.2f confidence=%.2f review=%s\n",
           assessment.assessment_id,
           assessment.program_id,
           assessment.ecosystem_type,
           assessment.condition_score,
           assessment.function_score,
           assessment.integrity_score,
           assessment.resilience_score,
           assessment.confidence,
           requires_review(assessment) ? "true" : "false");

    return 0;
}
