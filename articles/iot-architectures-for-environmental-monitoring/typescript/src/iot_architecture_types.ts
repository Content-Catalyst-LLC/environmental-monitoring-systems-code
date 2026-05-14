export type QualityFlag = "pass" | "suspect" | "fail" | "delayed" | "missing" | "calibration_expired";

export interface EnvironmentalObservation {
  observationId: string;
  deviceId: string;
  observedProperty: string;
  value: number | string | boolean;
  unit: string;
  phenomenonTime: string;
  resultTime: string;
  ingestedAt: string;
  latitude: number;
  longitude: number;
  siteId?: string;
  qualityFlag: QualityFlag;
  calibrationStatus: string;
  edgeRuleId?: string;
}

export interface DeviceCard {
  deviceId: string;
  domain: string;
  siteId: string;
  deviceType: string;
  observedProperty: string;
  unit: string;
  calibrationStatus: string;
  firmwareVersion: string;
  powerMode: string;
  owner: string;
  highStakesUse: boolean;
}

export interface AlertRule {
  alertRuleId: string;
  domain: string;
  observedProperty: string;
  thresholdType: "greater_than" | "less_than" | "z_score" | "rate_of_change";
  thresholdValue: number;
  severity: "low" | "medium" | "high" | "critical";
  owner: string;
  suppressionWindowMinutes: number;
  actionPathway: string;
}

export function requiresReview(observation: EnvironmentalObservation): boolean {
  return observation.qualityFlag !== "pass" || observation.calibrationStatus !== "valid" || !observation.unit || !observation.observedProperty;
}
