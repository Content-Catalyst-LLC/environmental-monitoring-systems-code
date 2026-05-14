export type EcologicalDimension =
  | "extent"
  | "condition"
  | "structure"
  | "function"
  | "integrity"
  | "resilience"
  | "disturbance"
  | "recovery";

export interface EcologicalIndicator {
  indicatorId: string;
  indicatorName: string;
  ecologicalDimension: EcologicalDimension;
  proxyMeaning: string;
  baselineOrReference: string;
  threshold: number;
  validUse: string;
  proxyLimit: string;
  reviewStatus: "approved" | "review_required" | "deprecated";
}

export interface EcosystemAssessment {
  assessmentId: string;
  programId: string;
  siteId: string;
  ecosystemType: string;
  assessmentDate: string;
  conditionScore: number;
  structureScore: number;
  functionScore: number;
  integrityScore: number;
  resilienceScore: number;
  confidence: number;
  reviewStatus: "approved" | "review_required" | "deprecated";
  notes?: string;
}

export interface EcosystemMonitoringReadinessCard {
  programId: string;
  ecosystemType: string;
  geography: string;
  extentVisibility: number;
  conditionEvidence: number;
  structureEvidence: number;
  functionEvidence: number;
  integrityEvidence: number;
  resilienceEvidence: number;
  baselineStrength: number;
  uncertaintyCommunication: number;
  governanceReadiness: number;
}

export function requiresReview(assessment: EcosystemAssessment): boolean {
  if (assessment.reviewStatus !== "approved") return true;
  if (assessment.confidence < 0.75) return true;
  if (assessment.conditionScore < 0.75) return true;
  if (assessment.functionScore < 0.70) return true;
  if (assessment.integrityScore < 0.70) return true;
  if (assessment.resilienceScore < 0.70) return true;
  return false;
}
