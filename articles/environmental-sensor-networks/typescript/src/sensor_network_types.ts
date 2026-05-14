export type NetworkQualityFlag =
  | "pass"
  | "suspect"
  | "review_required"
  | "delayed"
  | "delayed_local_storage"
  | "calibration_expired"
  | "missing"
  | "failed";

export interface NetworkObservation {
  observationId: string;
  nodeId: string;
  networkId: string;
  observedProperty: string;
  value: number | string | boolean;
  unit: string;
  phenomenonTime: string;
  resultTime: string;
  ingestedAt: string;
  qualityFlag: NetworkQualityFlag;
  calibrationStatus: string;
  telemetryStatus?: string;
  latitude?: number;
  longitude?: number;
}

export interface SensorNode {
  nodeId: string;
  networkId: string;
  domain: string;
  siteId: string;
  latitude: number;
  longitude: number;
  nodeType: string;
  observedProperty: string;
  unit: string;
  calibrationStatus: string;
  telemetryMode: string;
  owner: string;
  highStakesUse: boolean;
}

export interface NetworkReadinessCard {
  networkId: string;
  domain: string;
  networkType: string;
  spatialCoverage: number;
  temporalCompleteness: number;
  networkAvailability: number;
  representativeness: number;
  validDataShare: number;
  metadataMaturity: number;
  latencyReadiness: number;
  actionFit: number;
}

export function requiresReview(observation: NetworkObservation): boolean {
  if (observation.qualityFlag !== "pass") return true;
  if (observation.calibrationStatus !== "valid") return true;
  if (!observation.observedProperty || !observation.unit) return true;
  return false;
}
