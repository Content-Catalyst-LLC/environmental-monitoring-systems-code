# Climate Early Warning Systems

This companion directory supports the article **Climate Early Warning Systems**.

The article frames early warning as anticipatory governance infrastructure that connects:

- environmental observation, hazard monitoring, forecasting, and prediction
- exposure, vulnerability, impact thresholds, and risk knowledge
- warning decision rules, escalation protocols, and authority matrices
- communication channels, accessibility, trust, inclusion, and last-mile reach
- preparedness, early action, response capacity, after-action review, and governance learning

## Technical focus

This scaffold models climate early warning as an auditable protective lead-time system rather than a forecast service or alert feed.

Core engineering themes:

- forecast confidence
- risk knowledge
- protective lead time
- communication reach
- action capacity
- trust readiness
- inclusion capacity
- governance readiness
- false-alarm and missed-event review
- impact-based and multi-hazard warning logic

## Run examples

```bash
bash bash/validate_manifests.sh
python3 python/early_warning_readiness.py
Rscript r/early_warning_reporting.R
sqlite3 outputs/early_warning.db < sql/schema.sql
sqlite3 outputs/early_warning.db < sql/sample_queries.sql
```
