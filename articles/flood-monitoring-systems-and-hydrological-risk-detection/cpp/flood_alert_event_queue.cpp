#include <iostream>
#include <queue>
#include <string>

struct FloodAlertEvent {
    std::string event_id;
    std::string program_id;
    std::string flood_type;
    std::string warning_type;
    double protective_lead_time_hours;
    std::string status;
};

int main() {
    std::queue<FloodAlertEvent> alerts;

    alerts.push({"event-urban-flash", "urban-flash-flood-warning", "flash_flood", "flash_flood_alert", 0.67, "open"});
    alerts.push({"event-mainstem", "mainstem-river-forecast-system", "riverine", "river_flood_warning", 18.0, "open"});
    alerts.push({"event-reservoir", "reservoir-regulated-river-monitoring", "regulated_river", "operations_advisory", 5.0, "closed"});

    while (!alerts.empty()) {
        FloodAlertEvent alert = alerts.front();
        alerts.pop();

        std::cout << "event=" << alert.event_id
                  << " program=" << alert.program_id
                  << " flood_type=" << alert.flood_type
                  << " warning_type=" << alert.warning_type
                  << " lead_time_hours=" << alert.protective_lead_time_hours
                  << " status=" << alert.status
                  << std::endl;
    }

    return 0;
}
