#include <iostream>
#include <queue>
#include <string>

struct ClimateRecordEvent {
    std::string event_id;
    std::string platform_id;
    std::string climate_variable;
    std::string event_type;
    std::string status;
};

int main() {
    std::queue<ClimateRecordEvent> events;

    events.push({"event-001", "clim-002", "surface_temperature", "station_relocation_review", "review_required"});
    events.push({"event-002", "clim-004", "sea_level", "datum_review", "review_required"});
    events.push({"event-003", "clim-007", "land_surface_temperature", "satellite_intercalibration", "pass"});

    while (!events.empty()) {
        ClimateRecordEvent event = events.front();
        events.pop();

        std::cout << "event=" << event.event_id
                  << " platform=" << event.platform_id
                  << " variable=" << event.climate_variable
                  << " type=" << event.event_type
                  << " status=" << event.status
                  << std::endl;
    }

    return 0;
}
