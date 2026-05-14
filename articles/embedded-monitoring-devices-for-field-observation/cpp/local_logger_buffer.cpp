#include <iostream>
#include <queue>
#include <string>

struct FieldRecord {
    std::string observation_id;
    std::string device_id;
    std::string observed_property;
    double value;
    std::string quality_flag;
    bool delayed_record;
};

int main() {
    std::queue<FieldRecord> buffer;

    buffer.push({"obs-001", "river-stage-logger-001", "water_level", 2.74, "pass", false});
    buffer.push({"obs-004", "wetland-camera-trap-004", "habitat_activity", 1.0, "delayed_local_storage", true});
    buffer.push({"obs-006", "stormwater-flow-node-006", "flow_rate", 810.0, "calibration_expired", false});

    while (!buffer.empty()) {
        FieldRecord record = buffer.front();
        buffer.pop();

        std::cout << "field_record observation=" << record.observation_id
                  << " device=" << record.device_id
                  << " property=" << record.observed_property
                  << " value=" << record.value
                  << " quality=" << record.quality_flag
                  << " delayed=" << (record.delayed_record ? "true" : "false")
                  << std::endl;
    }

    return 0;
}
