#include <iostream>
#include <queue>
#include <string>

struct Event {
    std::string source_id;
    std::string observed_property;
    double value;
};

int main() {
    std::queue<Event> buffer;

    buffer.push({"sensor-water-001", "turbidity", 14.2});
    buffer.push({"sensor-water-001", "dissolved_oxygen", 8.1});

    while (!buffer.empty()) {
        Event event = buffer.front();
        buffer.pop();

        std::cout << "buffered_event source=" << event.source_id
                  << " property=" << event.observed_property
                  << " value=" << event.value << std::endl;
    }

    return 0;
}
