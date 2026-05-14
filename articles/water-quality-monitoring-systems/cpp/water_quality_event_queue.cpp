#include <iostream>
#include <queue>
#include <string>

struct WaterQualityEvent {
    std::string event_id;
    std::string site_id;
    std::string parameter_id;
    double value;
    std::string unit;
    std::string response_action;
    std::string quality_flag;
};

int main() {
    std::queue<WaterQualityEvent> events;

    events.push({"event-001", "wq-002", "turb", 135.0, "NTU", "trigger_storm_event_review", "review_required"});
    events.push({"event-002", "wq-005", "ecoli", 420.0, "CFU_100mL", "issue_or_review_advisory", "pass"});
    events.push({"event-003", "wq-006", "pfas", 12.0, "ng_L", "confirmatory_sampling_required", "review_required"});

    while (!events.empty()) {
        WaterQualityEvent event = events.front();
        events.pop();

        std::cout << "event=" << event.event_id
                  << " site=" << event.site_id
                  << " parameter=" << event.parameter_id
                  << " value=" << event.value
                  << " unit=" << event.unit
                  << " action=" << event.response_action
                  << " quality=" << event.quality_flag
                  << std::endl;
    }

    return 0;
}
