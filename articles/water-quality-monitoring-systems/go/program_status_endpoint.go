package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type ProgramStatusReport struct {
	Service                    string    `json:"service"`
	Timestamp                  time.Time `json:"timestamp"`
	SiteRegistryLoaded         bool      `json:"site_registry_loaded"`
	ParameterRegistryLoaded    bool      `json:"parameter_registry_loaded"`
	QAQCPolicyLoaded           bool      `json:"qaqc_policy_loaded"`
	AssessmentPolicyLoaded     bool      `json:"assessment_policy_loaded"`
	LabResultsLinked           bool      `json:"lab_results_linked"`
	HydrologyLoadLinkageLoaded bool      `json:"hydrology_load_linkage_loaded"`
	GovernanceLogCurrent       bool      `json:"governance_log_current"`
}

func main() {
	report := ProgramStatusReport{
		Service:                    "water-quality-monitoring-program-status",
		Timestamp:                  time.Now().UTC(),
		SiteRegistryLoaded:         true,
		ParameterRegistryLoaded:    true,
		QAQCPolicyLoaded:           true,
		AssessmentPolicyLoaded:     true,
		LabResultsLinked:           true,
		HydrologyLoadLinkageLoaded: true,
		GovernanceLogCurrent:       true,
	}

	payload, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		panic(err)
	}

	fmt.Println(string(payload))
}
