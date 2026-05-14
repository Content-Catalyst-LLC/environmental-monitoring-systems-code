#include <iostream>
#include <queue>
#include <string>

struct ObservationEvent {
    std::string observation_id;
    std::string program_id;
    std::string taxon_group;
    std::string method_id;
    std::string quality_flag;
    std::string detectability_note;
};

int main() {
    std::queue<ObservationEvent> review_queue;

    review_queue.push({"obs-001", "forest-biodiversity-monitoring", "birds", "acoustic_recorder", "pass", "seasonal vocal activity"});
    review_queue.push({"obs-004", "stream-edna-monitoring", "fish", "edna", "review_required", "DNA transport and persistence"});
    review_queue.push({"obs-006", "urban-biodiversity-monitoring", "birds", "citizen_science", "review_required", "uneven effort"});

    while (!review_queue.empty()) {
        ObservationEvent event = review_queue.front();
        review_queue.pop();

        std::cout << "observation=" << event.observation_id
                  << " program=" << event.program_id
                  << " taxon=" << event.taxon_group
                  << " method=" << event.method_id
                  << " quality=" << event.quality_flag
                  << " detectability=" << event.detectability_note
                  << std::endl;
    }

    return 0;
}
