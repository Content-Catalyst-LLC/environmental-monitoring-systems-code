export type Pollutant =
  | "PM2.5"
  | "PM10"
  | "O3"
  | "NO2"
  | "SO2"
  | "CO"
  | "VOCs"
  | "black_carbon"
  | "AOD_PM2.5_proxy";

export type PlatformType =
  | "fixed_station"
  | "distributed_sensor"
  | "mobile_platform"
  | "remote_sensing"
  | "community_sensor";

export interface AirQualitySensor {
  sensorId: string;
  sensorName: string;
  platformType: PlatformType;
  instrumentClass: "reference_grade" | "research_grade" | "low_cost_sensor" | "supplemental_sensor" | "satellite_product";
  owner: string;
  latitude?: number;
  longitude?: number;
  pollutants: Pollutant[];
  updateFrequencyMinutes: number;
  operationalStatus: "active" | "review_required" | "offline";
  validUse: string;
}

export interface PollutantObservation {
  observationId: string;
  sensorId: string;
  observationTime: string;
  pollutant: Pollutant;
  value: number;
  unit: string;
  averagingPeriodMinutes: number;
  qcFlag: "pass" | "review_required" | "suspect" | "excluded";
  calibrationStatus: "current" | "collocation_pending" | "expired" | "retrieval_validated";
}

export interface AirQualityReadinessCard {
  programId: string;
  monitoringPurpose: string;
  pollutantFocus: string;
  calibrationQuality: number;
  dataCompleteness: number;
  spatialCoverage: number;
  temporalCoverage: number;
  meteorologicalContext: number;
  exposureRelevance: number;
  uncertaintyCommunication: number;
  governanceReadiness: number;
}

export function meanConcentration(values: number[]): number {
  if (values.length === 0) return Number.NaN;
  return values.reduce((sum, value) => sum + value, 0) / values.length;
}

export function requiresReview(observation: PollutantObservation): boolean {
  return observation.qcFlag !== "pass" || observation.calibrationStatus === "expired";
}
