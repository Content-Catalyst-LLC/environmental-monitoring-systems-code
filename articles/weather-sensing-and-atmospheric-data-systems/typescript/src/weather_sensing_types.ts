export type WeatherPlatformType =
  | "surface_station"
  | "automated_airport_station"
  | "upper_air_radiosonde"
  | "wind_profiler"
  | "weather_radar"
  | "satellite"
  | "aircraft_reports"
  | "marine_buoy"
  | "ship_report"
  | "lightning_network";

export interface ObservationPlatform {
  platformId: string;
  platformName: string;
  platformType: WeatherPlatformType;
  owner: string;
  latitude?: number;
  longitude?: number;
  elevationM?: number;
  variables: string[];
  updateFrequencyMinutes: number;
  operationalStatus: "active" | "review_required" | "offline";
  assimilationRelevance: "high" | "medium" | "low";
}

export interface AtmosphericObservation {
  observationId: string;
  platformId: string;
  observationTime: string;
  arrivalTime: string;
  variable: string;
  value: number;
  unit: string;
  latitude?: number;
  longitude?: number;
  platformType: WeatherPlatformType;
  qcFlag: "pass" | "review_required" | "suspect" | "excluded";
  assimilationEligible: boolean;
}

export interface WeatherSensingReadinessCard {
  programId: string;
  operationalUse: string;
  geography: string;
  observationFreshness: number;
  spatialCoverage: number;
  verticalCoverage: number;
  qcCompleteness: number;
  assimilationReadiness: number;
  representativeness: number;
  uncertaintyCommunication: number;
  governanceReadiness: number;
}

export function observationLatencyMinutes(observationTimeMs: number, arrivalTimeMs: number): number {
  return (arrivalTimeMs - observationTimeMs) / (1000 * 60);
}

export function requiresReview(observation: AtmosphericObservation): boolean {
  return observation.qcFlag !== "pass" || !observation.assimilationEligible;
}
