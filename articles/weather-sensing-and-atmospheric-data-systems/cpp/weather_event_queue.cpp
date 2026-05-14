#include <iostream>
#include <queue>
#include <string>

struct WeatherSensingEvent {
    std::string event_id;
    std::string platform_id;
    std::string event_type;
    double latency_minutes;
    std::string qc_status;
    bool assimilation_ready;
};

int main() {
    std::queue<WeatherSensingEvent> events;

    events.push({"event-001", "met-001", "surface_observation", 2.0, "pass", true});
    events.push({"event-002", "met-004", "radar_nowcast_feature", 3.0, "pass", true});
    events.push({"event-003", "met-007", "marine_buoy_report", 45.0, "review_required", false});

    while (!events.empty()) {
        WeatherSensingEvent event = events.front();
        events.pop();

        std::cout << "event=" << event.event_id
                  << " platform=" << event.platform_id
                  << " type=" << event.event_type
                  << " latency_minutes=" << event.latency_minutes
                  << " qc=" << event.qc_status
                  << " assimilation_ready=" << (event.assimilation_ready ? "true" : "false")
                  << std::endl;
    }

    return 0;
}
