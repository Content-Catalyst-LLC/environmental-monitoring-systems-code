export type FloodType =
  | "riverine"
  | "flash_flood"
  | "regulated_river"
  | "urban_pluvial"
  | "compound_flood"
  | "coastal_river";

export interface FloodObservationRecord {
  recordId: string;
  stationId: string;
  timestamp: string;
  observedVariable: string;
  value: number;
  unit: string;
  qualityFlag: "pass" | "review_required" | "suspect" | "excluded";
  eventContext?: string;
}

export interface FloodMonitoringReadinessCard {
  programId: string;
  floodType: FloodType;
  geography: string;
  gaugeCoverage: number;
  rainfallCoverage: number;
  telemetryCompleteness: number;
  forecastConfidence: number;
  inundationMapReadiness: number;
  protectiveLeadTime: number;
  communicationReadiness: number;
  responseCapacity: number;
  governanceReadiness: number;
}

export function requiresReview(record: FloodObservationRecord): boolean {
  return record.qualityFlag !== "pass";
}

export function rateOfRise(currentStage: number, previousStage: number, deltaHours: number): number {
  if (deltaHours <= 0) {
    throw new Error("deltaHours must be positive");
  }
  return (currentStage - previousStage) / deltaHours;
}
