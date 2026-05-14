#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *change_id;
    const char *product_id;
    const char *from_class;
    const char *to_class;
    const char *change_type;
    int change_year;
    double confidence;
    double persistence_score;
    bool validated;
} LandChangeRecord;

bool requires_review(LandChangeRecord change) {
    return !change.validated || change.confidence < 0.80 || change.persistence_score < 0.75;
}

int main(void) {
    LandChangeRecord change = {
        .change_id = "chg-001",
        .product_id = "annual-land-cover-change",
        .from_class = "forest",
        .to_class = "cropland",
        .change_type = "conversion",
        .change_year = 2021,
        .confidence = 0.88,
        .persistence_score = 0.92,
        .validated = true
    };

    printf("change=%s product=%s transition=%s_to_%s type=%s year=%d confidence=%.2f persistence=%.2f review=%s\n",
           change.change_id,
           change.product_id,
           change.from_class,
           change.to_class,
           change.change_type,
           change.change_year,
           change.confidence,
           change.persistence_score,
           requires_review(change) ? "true" : "false");

    return 0;
}
