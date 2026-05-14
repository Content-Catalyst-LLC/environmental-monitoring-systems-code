#include <iostream>
#include <queue>
#include <string>

struct TileChange {
    std::string tile_id;
    std::string product_id;
    std::string from_class;
    std::string to_class;
    std::string change_type;
    double confidence;
    bool validated;
};

int main() {
    std::queue<TileChange> review_queue;

    review_queue.push({"tile-001", "annual-land-cover-change", "forest", "cropland", "conversion", 0.88, true});
    review_queue.push({"tile-002", "wetland-condition-change", "wetland", "wetland", "within_class_condition_change", 0.76, true});
    review_queue.push({"tile-003", "restoration-trajectory-monitoring", "barren", "restoration", "recovery", 0.72, false});

    while (!review_queue.empty()) {
        TileChange change = review_queue.front();
        review_queue.pop();

        std::cout << "tile=" << change.tile_id
                  << " product=" << change.product_id
                  << " from=" << change.from_class
                  << " to=" << change.to_class
                  << " type=" << change.change_type
                  << " confidence=" << change.confidence
                  << " validated=" << (change.validated ? "true" : "false")
                  << std::endl;
    }

    return 0;
}
