#include <iostream>
#include <queue>
#include <string>

struct EarlyWarningEvent {
    std::string event_id;
    std::string program_id;
    std::string hazard_type;
    std::string warning_level;
    double protective_lead_time_hours;
    std::string action_status;
};

int main() {
    std::queue<EarlyWarningEvent> events;

    events.push({"event-001", "flash-flood-early-warning", "flood", "warning", 1.67, "road_closure_review_open"});
    events.push({"event-002", "heat-health-warning-system", "heat", "warning", 9.0, "cooling_center_activation_open"});
    events.push({"event-003", "drought-anticipatory-action", "drought", "early_action", 648.0, "finance_review_open"});

    while (!events.empty()) {
        EarlyWarningEvent event = events.front();
        events.pop();

        std::cout << "event=" << event.event_id
                  << " program=" << event.program_id
                  << " hazard=" << event.hazard_type
                  << " level=" << event.warning_level
                  << " lead_time_hours=" << event.protective_lead_time_hours
                  << " action_status=" << event.action_status
                  << std::endl;
    }

    return 0;
}
