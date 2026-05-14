#include <iostream>
#include <queue>
#include <string>

struct GatewayEvent { std::string gateway_id; std::string device_id; std::string event_type; std::string review_priority; };

int main() {
    std::queue<GatewayEvent> buffer;
    buffer.push({"gateway-coastal-b", "coastal-buoy-002", "delayed_satellite_delivery", "latency_review"});
    buffer.push({"gateway-storm-f", "storm-drain-006", "calibration_expired_high_flow", "high_stakes_qc_review"});
    buffer.push({"gateway-river-a", "river-node-001", "threshold_crossing_logged", "routine_monitoring"});
    while (!buffer.empty()) {
        auto event = buffer.front(); buffer.pop();
        std::cout << "gateway_event gateway=" << event.gateway_id << " device=" << event.device_id
                  << " type=" << event.event_type << " review=" << event.review_priority << std::endl;
    }
    return 0;
}
