#include <iostream>
#include <queue>
#include <string>

struct IndicatorEvent {
    std::string indicator_id;
    std::string event_type;
    std::string review_status;
};

int main() {
    std::queue<IndicatorEvent> buffer;

    buffer.push({"water-withdrawal-001", "threshold_proximity", "feedback_required"});
    buffer.push({"biodiversity-habitat-001", "indicator_integrity_gap", "accountability_required"});
    buffer.push({"air-quality-exposure-001", "equity_threshold_exceeded", "corrective_action_required"});

    while (!buffer.empty()) {
        IndicatorEvent event = buffer.front();
        buffer.pop();

        std::cout << "indicator_event indicator=" << event.indicator_id
                  << " type=" << event.event_type
                  << " status=" << event.review_status
                  << std::endl;
    }

    return 0;
}
