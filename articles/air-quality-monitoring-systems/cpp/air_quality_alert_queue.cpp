#include <iostream>
#include <queue>
#include <string>

struct AirQualityAlertEvent {
    std::string event_id;
    std::string program_id;
    std::string pollutant;
    double value;
    std::string unit;
    std::string message_type;
};

int main() {
    std::queue<AirQualityAlertEvent> events;

    events.push({"event-001", "reference-regulatory-network", "PM2.5", 11.4, "ug_m3", "dashboard_update"});
    events.push({"event-002", "near-road-monitoring", "NO2", 41.0, "ppb", "technical_review"});
    events.push({"event-003", "wildfire-smoke-monitoring", "PM2.5", 36.5, "ug_m3", "public_health_advisory"});

    while (!events.empty()) {
        AirQualityAlertEvent event = events.front();
        events.pop();

        std::cout << "event=" << event.event_id
                  << " program=" << event.program_id
                  << " pollutant=" << event.pollutant
                  << " value=" << event.value
                  << " unit=" << event.unit
                  << " message_type=" << event.message_type
                  << std::endl;
    }

    return 0;
}
