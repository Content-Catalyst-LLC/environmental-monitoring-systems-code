package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type ProgramStatusReport struct {
	Service                    string    `json:"service"`
	Timestamp                  time.Time `json:"timestamp"`
	HazardRegistryLoaded       bool      `json:"hazard_registry_loaded"`
	ForecastRecordsLoaded      bool      `json:"forecast_records_loaded"`
	RiskKnowledgeLoaded        bool      `json:"risk_knowledge_loaded"`
	WarningPolicyLoaded        bool      `json:"warning_policy_loaded"`
	CommunicationPolicyLoaded  bool      `json:"communication_policy_loaded"`
	PreparednessLogCurrent     bool      `json:"preparedness_log_current"`
	GovernanceLogCurrent       bool      `json:"governance_log_current"`
}

func main() {
	report := ProgramStatusReport{
		Service:                   "early-warning-program-status",
		Timestamp:                 time.Now().UTC(),
		HazardRegistryLoaded:      true,
		ForecastRecordsLoaded:     true,
		RiskKnowledgeLoaded:       true,
		WarningPolicyLoaded:       true,
		CommunicationPolicyLoaded: true,
		PreparednessLogCurrent:    true,
		GovernanceLogCurrent:      true,
	}

	payload, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		panic(err)
	}

	fmt.Println(string(payload))
}
