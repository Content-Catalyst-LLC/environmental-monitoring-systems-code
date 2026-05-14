export interface SoilObservationRecord {
  recordId: string;
  sensorId: string;
  timestamp: string;
  parameter: string;
  value: number;
  unit: string;
  qualityFlag: "pass" | "review_required" | "suspect" | "excluded";
  telemetryStatus: "received" | "missing" | "stale" | "delayed";
}

export interface SoilMonitoringReadinessCard {
  programId: string;
  cropOrSystem: string;
  geography: string;
  spatialRepresentativeness: number;
  depthRepresentation: number;
  calibrationQuality: number;
  telemetryCompleteness: number;
  laboratorySupport: number;
  remoteProductAgreement: number;
  uncertaintyCommunication: number;
  decisionReadiness: number;
}

export function requiresReview(record: SoilObservationRecord): boolean {
  return record.qualityFlag !== "pass" || record.telemetryStatus !== "received";
}
