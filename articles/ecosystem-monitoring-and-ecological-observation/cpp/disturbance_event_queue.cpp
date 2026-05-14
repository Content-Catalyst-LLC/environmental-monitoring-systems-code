#include <iostream>
#include <queue>
#include <string>

struct DisturbanceEvent {
    std::string event_id;
    std::string program_id;
    std::string ecosystem_type;
    std::string event_type;
    double intensity_score;
    double spatial_extent_ha;
    std::string recovery_status;
};

int main() {
    std::queue<DisturbanceEvent> review_queue;

    review_queue.push({"evt-001", "wetland-integrity-monitoring", "wetland", "drought", 0.70, 420.0, "partial_recovery"});
    review_queue.push({"evt-002", "forest-condition-monitoring", "forest", "fire", 0.82, 950.0, "recovering"});
    review_queue.push({"evt-003", "stream-ecological-condition", "river_stream", "pollution_pulse", 0.64, 18.0, "uncertain"});

    while (!review_queue.empty()) {
        DisturbanceEvent event = review_queue.front();
        review_queue.pop();

        std::cout << "event=" << event.event_id
                  << " program=" << event.program_id
                  << " ecosystem=" << event.ecosystem_type
                  << " type=" << event.event_type
                  << " intensity=" << event.intensity_score
                  << " extent_ha=" << event.spatial_extent_ha
                  << " recovery=" << event.recovery_status
                  << std::endl;
    }

    return 0;
}
