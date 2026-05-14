#include <iostream>
#include <queue>
#include <string>

struct EdgeEvent {
    std::string event_id;
    std::string component_id;
    std::string event_type;
    bool delayed_record;
    bool raw_context_retained;
};

int main() {
    std::queue<EdgeEvent> replay_queue;

    replay_queue.push({"evt-001", "flood-threshold-gateway", "threshold_crossing", false, true});
    replay_queue.push({"evt-002", "acoustic-biodiversity-node", "local_classification", true, true});
    replay_queue.push({"evt-005", "stormwater-flow-alert-system", "local_alarm", false, true});

    while (!replay_queue.empty()) {
        EdgeEvent event = replay_queue.front();
        replay_queue.pop();

        std::cout << "edge_event event=" << event.event_id
                  << " component=" << event.component_id
                  << " type=" << event.event_type
                  << " delayed=" << (event.delayed_record ? "true" : "false")
                  << " raw_context_retained=" << (event.raw_context_retained ? "true" : "false")
                  << std::endl;
    }

    return 0;
}
