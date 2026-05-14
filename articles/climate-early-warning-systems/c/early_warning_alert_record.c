#include <stdio.h>
#include <stdbool.h>

typedef struct {
    const char *decision_id;
    const char *program_id;
    const char *hazard_type;
    const char *warning_level;
    double protective_lead_time_hours;
    bool issued;
} EarlyWarningAlertRecord;

bool requires_lead_time_review(EarlyWarningAlertRecord record) {
    return record.issued && record.protective_lead_time_hours < 2.0;
}

int main(void) {
    EarlyWarningAlertRecord record = {
        .decision_id = "warn-001",
        .program_id = "flash-flood-early-warning",
        .hazard_type = "flood",
        .warning_level = "warning",
        .protective_lead_time_hours = 1.67,
        .issued = true
    };

    printf("decision=%s program=%s hazard=%s level=%s lead_time=%.2f review=%s\n",
           record.decision_id,
           record.program_id,
           record.hazard_type,
           record.warning_level,
           record.protective_lead_time_hours,
           requires_lead_time_review(record) ? "true" : "false");

    return 0;
}
