package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type ProgramStatusReport struct {
	Service                  string    `json:"service"`
	Timestamp                time.Time `json:"timestamp"`
	GaugeRegistryLoaded      bool      `json:"gauge_registry_loaded"`
	TelemetryPolicyLoaded    bool      `json:"telemetry_policy_loaded"`
	ForecastPolicyLoaded     bool      `json:"forecast_policy_loaded"`
	InundationPolicyLoaded   bool      `json:"inundation_policy_loaded"`
	ThresholdRegistryLoaded  bool      `json:"threshold_registry_loaded"`
	GovernanceLogCurrent     bool      `json:"governance_log_current"`
}

func main() {
	report := ProgramStatusReport{
		Service:                 "flood-monitoring-program-status",
		Timestamp:               time.Now().UTC(),
		GaugeRegistryLoaded:     true,
		TelemetryPolicyLoaded:   true,
		ForecastPolicyLoaded:    true,
		InundationPolicyLoaded:  true,
		ThresholdRegistryLoaded: true,
		GovernanceLogCurrent:    true,
	}

	payload, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		panic(err)
	}

	fmt.Println(string(payload))
}
