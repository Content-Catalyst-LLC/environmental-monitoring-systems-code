#include <iostream>
#include <queue>
#include <string>

struct ResilienceEvent {
    std::string unit_id;
    std::string event_type;
    double threshold_proximity;
};

int main() {
    std::queue<ResilienceEvent> buffer;

    buffer.push({"urban-heat-zone-001", "threshold_warning", 0.91});
    buffer.push({"forest-fire-zone-004", "threshold_warning", 0.93});

    while (!buffer.empty()) {
        ResilienceEvent event = buffer.front();
        buffer.pop();

        std::cout << "resilience_event unit=" << event.unit_id
                  << " type=" << event.event_type
                  << " threshold_proximity=" << event.threshold_proximity
                  << std::endl;
    }

    return 0;
}
