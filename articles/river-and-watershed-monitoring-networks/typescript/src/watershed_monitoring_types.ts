export type BasinPosition =
  | "headwater"
  | "tributary"
  | "mainstem"
  | "outlet"
  | "regulated_reach"
  | "baseflow_zone";

export interface MonitoringNode {
  nodeId: string;
  stationId: string;
  stationName: string;
  siteType: string;
  basinPosition: BasinPosition;
  monitoredVariables: string[];
  latitude: number;
  longitude: number;
  upstreamAreaKm2: number;
  agency: string;
  continuityStatus: string;
  telemetryStatus: string;
}

export interface WaterQualityLoadRecord {
  recordId: string;
  stationId: string;
  timestamp: string;
  constituent: string;
  concentrationMgL: number;
  dischargeM3S: number;
  instantaneousLoadKgDay: number;
  eventFlag: "baseflow" | "storm_event" | "low_flow" | "flood_pulse";
  qualityFlag: "pass" | "review_required" | "suspect" | "excluded";
}

export interface WatershedReadinessCard {
  networkId: string;
  basinContext: string;
  geography: string;
  gaugeCoverage: number;
  waterQualityCoverage: number;
  ecologicalCoverage: number;
  networkRepresentativeness: number;
  temporalContinuity: number;
  eventCapture: number;
  uncertaintyCommunication: number;
  interoperability: number;
  governanceReadiness: number;
}

export function instantaneousLoadKgDay(concentrationMgL: number, dischargeM3S: number): number {
  return concentrationMgL * dischargeM3S * 86.4;
}

export function requiresReview(record: WaterQualityLoadRecord): boolean {
  return record.qualityFlag !== "pass";
}
