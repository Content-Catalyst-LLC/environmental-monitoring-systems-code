#include <iostream>
#include <queue>
#include <string>

struct AlertEvent {
    std::string alert_id;
    std::string program_id;
    std::string severity;
    std::string response_owner;
    std::string review_status;
};

int main() {
    std::queue<AlertEvent> alerts;
    alerts.push({"alert-001", "distribution-online-quality", "high", "water_quality_team", "approved"});
    alerts.push({"alert-004", "wet-weather-smart-sewer", "high", "wet_weather_team", "review_required"});

    while (!alerts.empty()) {
        AlertEvent alert = alerts.front();
        alerts.pop();
        std::cout << "alert=" << alert.alert_id
                  << " program=" << alert.program_id
                  << " severity=" << alert.severity
                  << " owner=" << alert.response_owner
                  << " status=" << alert.review_status << std::endl;
    }
    return 0;
}
