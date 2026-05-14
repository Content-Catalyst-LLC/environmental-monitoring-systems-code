#include <iostream>
#include <queue>
#include <string>

struct SoilTelemetryRecord {
    std::string record_id;
    std::string sensor_id;
    std::string parameter;
    double value;
    std::string status;
};

int main() {
    std::queue<SoilTelemetryRecord> records;
    records.push({"rec-001", "sm-001", "volumetric_water_content", 0.24, "received"});
    records.push({"rec-003", "sm-003", "volumetric_water_content", 0.15, "review_required"});

    while (!records.empty()) {
        SoilTelemetryRecord record = records.front();
        records.pop();
        std::cout << "record=" << record.record_id
                  << " sensor=" << record.sensor_id
                  << " parameter=" << record.parameter
                  << " value=" << record.value
                  << " status=" << record.status << std::endl;
    }
    return 0;
}
