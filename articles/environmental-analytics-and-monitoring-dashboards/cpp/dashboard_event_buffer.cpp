#include <iostream>
#include <queue>
#include <string>

struct DashboardEvent {
    std::string indicator_id;
    std::string event_type;
    std::string review_priority;
};

int main() {
    std::queue<DashboardEvent> buffer;

    buffer.push({"flood-inundation-model", "uncertainty_hidden", "uncertainty_visibility_review"});
    buffer.push({"compliance-summary", "high_alert_burden", "alert_burden_review"});
    buffer.push({"habitat-condition-map", "missing_provenance", "provenance_review"});

    while (!buffer.empty()) {
        DashboardEvent event = buffer.front();
        buffer.pop();

        std::cout << "dashboard_event indicator=" << event.indicator_id
                  << " type=" << event.event_type
                  << " review=" << event.review_priority
                  << std::endl;
    }

    return 0;
}
