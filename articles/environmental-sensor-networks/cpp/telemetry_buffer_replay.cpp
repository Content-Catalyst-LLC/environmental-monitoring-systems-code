#include <iostream>
#include <queue>
#include <string>

struct NetworkPacket {
    std::string observation_id;
    std::string node_id;
    std::string network_id;
    std::string quality_flag;
    bool delayed_record;
};

int main() {
    std::queue<NetworkPacket> replay_queue;

    replay_queue.push({"obs-001", "node-river-001", "river-watershed-network", "pass", false});
    replay_queue.push({"obs-004", "node-coastal-002", "coastal-buoy-network", "delayed", true});
    replay_queue.push({"obs-005", "node-eco-001", "restoration-ecology-network", "delayed_local_storage", true});

    while (!replay_queue.empty()) {
        NetworkPacket packet = replay_queue.front();
        replay_queue.pop();

        std::cout << "network_packet observation=" << packet.observation_id
                  << " node=" << packet.node_id
                  << " network=" << packet.network_id
                  << " quality=" << packet.quality_flag
                  << " delayed=" << (packet.delayed_record ? "true" : "false")
                  << std::endl;
    }

    return 0;
}
