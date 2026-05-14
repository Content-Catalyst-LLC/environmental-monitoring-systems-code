export type BiodiversityDimension =
  | "occurrence"
  | "abundance"
  | "distribution"
  | "community"
  | "genetic"
  | "habitat"
  | "function"
  | "pressure"
  | "response";

export interface SpeciesObservation {
  observationId: string;
  programId: string;
  siteId: string;
  taxonGroup: string;
  speciesOrTaxon: string;
  methodId: string;
  observationDate: string;
  detected: boolean;
  countOrIndex?: number | string;
  effortUnits: string;
  qualityFlag: "pass" | "review_required" | "suspect" | "excluded";
  detectabilityNote?: string;
  habitatContext?: string;
}

export interface BiodiversityIndicator {
  indicatorId: string;
  indicatorName: string;
  dimensionId: BiodiversityDimension;
  ebvLink: string;
  policyUse: string;
  proxyLimit: string;
  baselineOrReference: string;
  reviewStatus: "approved" | "review_required" | "deprecated";
}

export interface BiodiversityMonitoringReadinessCard {
  programId: string;
  ecosystemContext: string;
  geography: string;
  taxonomicCoverage: number;
  spatialRepresentativeness: number;
  methodDiversity: number;
  detectabilityAdjustment: number;
  observationQuality: number;
  indicatorReadiness: number;
  habitatContextLinkage: number;
  uncertaintyCommunication: number;
  governanceReadiness: number;
}

export function requiresReview(observation: SpeciesObservation): boolean {
  if (observation.qualityFlag !== "pass") return true;
  if (!observation.effortUnits) return true;
  if (!observation.detectabilityNote) return true;
  return false;
}
