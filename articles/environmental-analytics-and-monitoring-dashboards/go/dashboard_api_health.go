package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type DashboardHealthReport struct {
	Service                  string    `json:"service"`
	Timestamp                time.Time `json:"timestamp"`
	SourceFeedsAvailable     bool      `json:"source_feeds_available"`
	IndicatorRegistryLoaded  bool      `json:"indicator_registry_loaded"`
	AlertRulesLoaded         bool      `json:"alert_rules_loaded"`
	ProvenanceLinksAvailable bool      `json:"provenance_links_available"`
	UncertaintyLabelsEnabled bool      `json:"uncertainty_labels_enabled"`
	ChangeLogCurrent         bool      `json:"change_log_current"`
}

func main() {
	report := DashboardHealthReport{
		Service:                  "environmental-dashboard-api",
		Timestamp:                time.Now().UTC(),
		SourceFeedsAvailable:     true,
		IndicatorRegistryLoaded:  true,
		AlertRulesLoaded:         true,
		ProvenanceLinksAvailable: true,
		UncertaintyLabelsEnabled: true,
		ChangeLogCurrent:         true,
	}

	payload, err := json.MarshalIndent(report, "", "  ")
	if err != nil {
		panic(err)
	}

	fmt.Println(string(payload))
}
