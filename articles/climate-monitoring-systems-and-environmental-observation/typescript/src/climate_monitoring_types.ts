export type ClimateDomain =
  | "atmosphere"
  | "ocean"
  | "cryosphere"
  | "land"
  | "land_biosphere"
  | "hydrology"
  | "carbon_cycle"
  | "reanalysis";

export interface ClimateObservation {
  observationId: string;
  platformId: string;
  observationDate: string;
  domain: ClimateDomain;
  climateVariable: string;
  value: number;
  unit: string;
  qcFlag: "pass" | "review_required" | "suspect" | "excluded";
  recordStage: "raw_observation" | "qc_observation" | "adjusted_record" | "indicator";
  provenanceId: string;
}

export interface ClimateDataRecordManifest {
  recordId: string;
  recordTitle: string;
  domain: ClimateDomain;
  climateVariable: string;
  version: string;
  baselineStart: number;
  baselineEnd: number;
  recordStart: number;
  recordEnd: number;
  processingStatus: "approved" | "review_required" | "deprecated";
  uncertaintyStatement: string;
  citationRequired: boolean;
}

export interface ClimateMonitoringReadinessCard {
  programId: string;
  domain: ClimateDomain;
  climateVariable: string;
  recordContinuity: number;
  metadataCompleteness: number;
  calibrationQuality: number;
  homogenizationReadiness: number;
  spatialCoverage: number;
  versionControl: number;
  uncertaintyCommunication: number;
  governanceReadiness: number;
}

export function anomaly(value: number, baselineMean: number): number {
  return value - baselineMean;
}

export function requiresRecordReview(card: ClimateMonitoringReadinessCard): boolean {
  return (
    card.recordContinuity < 0.75 ||
    card.metadataCompleteness < 0.75 ||
    card.calibrationQuality < 0.75 ||
    card.homogenizationReadiness < 0.75
  );
}
