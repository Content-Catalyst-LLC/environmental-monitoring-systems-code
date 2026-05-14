#include <iostream>
#include <queue>
#include <string>

struct ProductEvent {
    std::string product_id;
    std::string event_type;
    std::string review_priority;
};

int main() {
    std::queue<ProductEvent> buffer;

    buffer.push({"sentinel-flood-extent", "weak_in_situ_validation", "validation_review"});
    buffer.push({"vegetation-stress-index", "proxy_transparency_gap", "proxy_transparency_review"});
    buffer.push({"sea-ice-continuity-record", "mission_transition_documented", "routine_monitoring"});

    while (!buffer.empty()) {
        ProductEvent event = buffer.front();
        buffer.pop();

        std::cout << "satellite_product_event product=" << event.product_id
                  << " type=" << event.event_type
                  << " review=" << event.review_priority
                  << std::endl;
    }

    return 0;
}
