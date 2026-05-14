export interface WaterObservationRecord {
  recordId: string;
  sensorId: string;
  timestamp: string;
  parameter: string;
  value: number | string;
  unit: string;
  qualityFlag: "pass" | "review_required" | "suspect" | "excluded";
  operationalContext: string;
}

export interface SmartWaterReadinessCard {
  programId: string;
  waterDomain: string;
  serviceGoal: string;
  sensingCoverage: number;
  dataQualityValidity: number;
  telemetryCompleteness: number;
  latencyReadiness: number;
  anomalyConfidence: number;
  responseCapacity: number;
  modelReadiness: number;
  controlSafety: number;
  governanceReadiness: number;
}

export function requiresReview(record: WaterObservationRecord): boolean {
  return record.qualityFlag !== "pass";
}
