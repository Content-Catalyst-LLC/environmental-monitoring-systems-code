package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type ProgramStatusReport struct {
	Service                    string    `json:"service"`
	Timestamp                  time.Time `json:"timestamp"`
	MonitoringObjectiveLoaded  bool      `json:"monitoring_objective_loaded"`
	MethodRegistryLoaded       bool      `json:"method_registry_loaded"`
	ObservationRecordsLoaded   bool      `json:"observation_records_loaded"`
	DetectabilityPolicyLoaded  bool      `json:"detectability_policy_loaded"`
	IndicatorRegistryLoaded    bool      `json:"indicator_registry_loaded"`
	InclusionPolicyLoaded      bool      `json:"inclusion_policy_loaded"`
	GovernanceLogCurrent       bool      `json:"governance_log_current"`
}

func main() {
	report := ProgramStatusReport{
		Service:                   "biodiversity-monitoring-program-status",
		Timestamp:                 time.Now().UTC(),
		MonitoringObjectiveLoaded: true,
		MethodRegistryLoaded:      true,
		ObservationRecordsLoaded:  true,
		DetectabilityPolicyLoaded: true,
		IndicatorRegistryLoaded:   true,
		InclusionPolicyLoaded:     true,
		GovernanceLogCurrent:      true,
	}

	payload, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		panic(err)
	}

	fmt.Println(string(payload))
}
