export type LandChangeType =
  | "conversion"
  | "degradation"
  | "recovery"
  | "disturbance"
  | "within_class_condition_change"
  | "fragmentation"
  | "intensification";

export interface LandClass {
  classId: string;
  className: string;
  classGroup: "land_cover" | "land_use" | "land_cover_land_use" | "land_cover_condition" | "land_use_condition";
  definition: string;
  monitoringNote?: string;
}

export interface LandChangeRecord {
  changeId: string;
  productId: string;
  geography: string;
  siteId?: string;
  fromClass: string;
  toClass: string;
  changeType: LandChangeType;
  changeYear: number;
  confidence: number;
  persistenceScore: number;
  validated: boolean;
  reportingRelevance: string;
  notes?: string;
}

export interface AccuracyAssessment {
  assessmentId: string;
  productId: string;
  className: string;
  referenceSamples: number;
  correctSamples: number;
  usersAccuracy: number;
  producersAccuracy: number;
  mappedAreaHa: number;
  adjustedAreaHa: number;
  areaUncertaintyHa: number;
}

export interface LandMonitoringReadinessCard {
  productId: string;
  geography: string;
  monitoringPurpose: string;
  classificationAccuracy: number;
  temporalConsistency: number;
  changeConfidence: number;
  referenceDataStrength: number;
  conditionSensitivity: number;
  fragmentationVisibility: number;
  uncertaintyCommunication: number;
  reportingReadiness: number;
}

export function requiresReview(change: LandChangeRecord): boolean {
  if (!change.validated) return true;
  if (change.confidence < 0.8) return true;
  if (change.persistenceScore < 0.75) return true;
  return false;
}
