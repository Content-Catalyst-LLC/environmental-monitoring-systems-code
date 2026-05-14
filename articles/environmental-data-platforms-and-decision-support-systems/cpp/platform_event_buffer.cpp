#include <iostream>
#include <queue>
#include <string>

struct PlatformEvent {
    std::string asset_id;
    std::string event_type;
    std::string review_priority;
};

int main() {
    std::queue<PlatformEvent> buffer;

    buffer.push({"flood-scenario-model-002", "uncertainty_visibility_gap", "uncertainty_visibility_review"});
    buffer.push({"habitat-layer-003", "metadata_semantic_gap", "semantic_integration_review"});
    buffer.push({"compliance-records-005", "high_stakes_lineage_check", "high_stakes_lineage_review"});

    while (!buffer.empty()) {
        PlatformEvent event = buffer.front();
        buffer.pop();

        std::cout << "platform_event asset=" << event.asset_id
                  << " type=" << event.event_type
                  << " review=" << event.review_priority
                  << std::endl;
    }

    return 0;
}
