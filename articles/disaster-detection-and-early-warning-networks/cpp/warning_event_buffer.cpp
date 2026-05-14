#include <iostream>
#include <queue>
#include <string>

struct WarningEvent {
    std::string scenario_id;
    std::string event_stage;
    std::string evidence_record;
};

int main() {
    std::queue<WarningEvent> buffer;

    buffer.push({"flood-urban-001", "observation", "river_stage_above_warning_threshold"});
    buffer.push({"flood-urban-001", "warning_decision", "public_warning_issued"});
    buffer.push({"flood-urban-001", "communication", "mobile_and_radio_alerts_sent"});

    while (!buffer.empty()) {
        WarningEvent event = buffer.front();
        buffer.pop();

        std::cout << "warning_event scenario=" << event.scenario_id
                  << " stage=" << event.event_stage
                  << " evidence=" << event.evidence_record
                  << std::endl;
    }

    return 0;
}
