package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type ProductStatusReport struct {
	Service                    string    `json:"service"`
	Timestamp                  time.Time `json:"timestamp"`
	ClassLegendLoaded          bool      `json:"class_legend_loaded"`
	ImageryInventoryLoaded     bool      `json:"imagery_inventory_loaded"`
	ReferenceSamplesLoaded     bool      `json:"reference_samples_loaded"`
	ChangeRulesLoaded          bool      `json:"change_rules_loaded"`
	AccuracyAssessmentLoaded   bool      `json:"accuracy_assessment_loaded"`
	UncertaintyStatementLoaded bool      `json:"uncertainty_statement_loaded"`
	GovernanceLogCurrent       bool      `json:"governance_log_current"`
}

func main() {
	report := ProductStatusReport{
		Service:                    "land-monitoring-product-status",
		Timestamp:                  time.Now().UTC(),
		ClassLegendLoaded:          true,
		ImageryInventoryLoaded:     true,
		ReferenceSamplesLoaded:     true,
		ChangeRulesLoaded:          true,
		AccuracyAssessmentLoaded:   true,
		UncertaintyStatementLoaded: true,
		GovernanceLogCurrent:       true,
	}

	payload, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		panic(err)
	}

	fmt.Println(string(payload))
}
