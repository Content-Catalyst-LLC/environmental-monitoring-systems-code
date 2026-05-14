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

    buffer.push({"sentinel-sar-flood-extent", "weak_field_validation", "field_validation_review"});
    buffer.push({"vegetation-stress-index", "proxy_transparency_gap", "proxy_transparency_review"});
    buffer.push({"drone-restoration-cover", "time_series_continuity_gap", "time_series_continuity_review"});

    while (!buffer.empty()) {
        ProductEvent event = buffer.front();
        buffer.pop();

        std::cout << "remote_sensing_product_event product=" << event.product_id
                  << " type=" << event.event_type
                  << " review=" << event.review_priority
                  << std::endl;
    }

    return 0;
}
