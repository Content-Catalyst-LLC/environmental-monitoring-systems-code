#include <iostream>
#include <queue>
#include <string>

struct WatershedEvent {
    std::string event_id;
    std::string station_id;
    std::string event_type;
    std::string constituent;
    double estimated_load_kg_day;
    std::string quality_flag;
};

int main() {
    std::queue<WatershedEvent> events;

    events.push({"event-001", "st-002", "storm_event", "nitrate", 11024.64, "pass"});
    events.push({"event-002", "st-003", "storm_event", "total_phosphorus", 186.62, "review_required"});
    events.push({"event-003", "st-006", "storm_event", "suspended_sediment", 477360.00, "pass"});

    while (!events.empty()) {
        WatershedEvent event = events.front();
        events.pop();

        std::cout << "event=" << event.event_id
                  << " station=" << event.station_id
                  << " type=" << event.event_type
                  << " constituent=" << event.constituent
                  << " load_kg_day=" << event.estimated_load_kg_day
                  << " quality=" << event.quality_flag
                  << std::endl;
    }

    return 0;
}
