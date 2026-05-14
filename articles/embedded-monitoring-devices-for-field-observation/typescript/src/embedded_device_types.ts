export type CalibrationStatus =
  | "valid"
  | "review_required"
  | "expired"
  | "unknown";

export type FieldQualityFlag =
  | "pass"
  | "suspect"
  | "review_required"
  | "calibration_expired"
  | "delayed_local_storage"
  | "missing"
  | "failed";

export interface FieldObservation {
  observationId: string;
  deviceId: string;
  observedProperty: string;
  value: number | string | boolean;
  unit: string;
  phenomenonTime: string;
  resultTime: string;
  ingestedAt: string;
  qualityFlag: FieldQualityFlag;
  calibrationStatus: CalibrationStatus;
  firmwareVersion: string;
  batteryVoltage?: number;
  storagePercentUsed?: number;
  clockDriftSeconds?: number;
  deviceHealthStatus?: string;
}

export interface DeviceCard {
  deviceId: string;
  domain: string;
  siteId: string;
  deviceType: string;
  sensorType: string;
  observedProperty: string;
  unit: string;
  firmwareVersion: string;
  calibrationStatus: CalibrationStatus;
  powerMode: string;
  telemetryMode: string;
  owner: string;
  highStakesUse: boolean;
}

export interface DeviceReadinessCard {
  deviceId: string;
  domain: string;
  deviceType: string;
  deviceAvailability: number;
  recordCompleteness: number;
  powerMarginScore: number;
  calibrationValidity: number;
  timingConsistency: number;
  qcReadiness: number;
  healthVisibility: number;
  decisionFit: number;
}

export function requiresReview(observation: FieldObservation): boolean {
  if (observation.qualityFlag !== "pass") return true;
  if (observation.calibrationStatus !== "valid") return true;
  if (observation.clockDriftSeconds !== undefined && Math.abs(observation.clockDriftSeconds) > 10) return true;
  return false;
}
