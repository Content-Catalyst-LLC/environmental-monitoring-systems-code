export type EdgeAutonomyLevel =
  | "observe"
  | "filter"
  | "prioritize"
  | "infer"
  | "alert"
  | "act";

export type EdgeQualityFlag =
  | "pass"
  | "suspect"
  | "preliminary"
  | "review_required"
  | "calibration_expired"
  | "failed";

export interface EdgeEvent {
  eventId: string;
  componentId: string;
  edgeRuleId: string;
  modelId?: string;
  modelVersion?: string;
  eventType: string;
  observedProperty?: string;
  value?: number | string | boolean;
  unit?: string;
  phenomenonTime: string;
  resultTime: string;
  ingestedAt: string;
  confidence?: number;
  qualityFlag: EdgeQualityFlag;
  rawContextRetained: boolean;
  delayedRecord: boolean;
  retainedContextUri?: string;
}

export interface EdgeRule {
  edgeRuleId: string;
  componentId: string;
  ruleType: "threshold" | "filter" | "classification" | "adaptive_sampling" | "compression" | "local_alarm";
  observedProperty: string;
  thresholdOrMethod: string;
  version: string;
  owner: string;
  autonomyLevel: EdgeAutonomyLevel;
  retentionRequirement: string;
  reviewStatus: "approved" | "review_required" | "blocked";
}

export interface EdgeReadinessCard {
  componentId: string;
  domain: string;
  componentType: string;
  latencyReadiness: number;
  bandwidthReduction: number;
  lossPenalty: number;
  retainedContextScore: number;
  edgeTraceability: number;
  qcReadiness: number;
  inferenceTransparency: number;
  decisionFit: number;
}

export function requiresHumanReview(event: EdgeEvent): boolean {
  if (event.qualityFlag !== "pass") return true;
  if (event.delayedRecord) return true;
  if (!event.rawContextRetained && event.confidence !== undefined && event.confidence < 0.90) return true;
  if (event.confidence !== undefined && event.confidence < 0.75) return true;
  return false;
}
