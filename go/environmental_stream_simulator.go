package main

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"time"
)

type EnvironmentalEvent struct {
	SensorID       string  `json:"sensor_id"`
	Domain         string  `json:"domain"`
	ObservedAt     string  `json:"observed_at"`
	RawValue       float64 `json:"raw_value"`
	BatteryVoltage float64 `json:"battery_voltage"`
	SignalQuality  float64 `json:"signal_quality"`
}

func main() {
	events := []EnvironmentalEvent{
		{
			SensorID:       "AIR-001",
			Domain:         "air_quality",
			ObservedAt:     time.Now().UTC().Format(time.RFC3339),
			RawValue:       rand.Float64() * 100,
			BatteryVoltage: 3.3 + rand.Float64()*0.8,
			SignalQuality:  0.7 + rand.Float64()*0.3,
		},
	}

	payload, _ := json.MarshalIndent(events, "", "  ")
	fmt.Println(string(payload))
}
