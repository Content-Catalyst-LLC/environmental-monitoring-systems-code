#include <stdio.h>

typedef struct {
    const char *signal_id;
    const char *hazard_type;
    double value;
    double warning_threshold;
    double critical_threshold;
} HazardSignal;

int main(void) {
    HazardSignal signal = {
        .signal_id = "sig-flood-001",
        .hazard_type = "flood",
        .value = 18.4,
        .warning_threshold = 17.0,
        .critical_threshold = 20.0
    };

    const char *status = "normal";
    if (signal.value >= signal.critical_threshold) {
        status = "critical";
    } else if (signal.value >= signal.warning_threshold) {
        status = "warning";
    }

    printf("signal=%s hazard=%s value=%.2f status=%s\n",
           signal.signal_id, signal.hazard_type, signal.value, status);

    return 0;
}
