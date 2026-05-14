export type HazardType =
  | "flood"
  | "heat"
  | "drought"
  | "wildfire"
  | "compound_coastal"
  | "severe_weather"
  | "cyclone"
  | "storm_surge"
  | "landslide";

export type WarningLevel =
  | "advisory"
  | "watch"
  | "warning"
  | "early_action"
  | "emergency";

export interface ForecastRecord {
  forecastId: string;
  hazardType: HazardType;
  programId: string;
  forecastIssueTime: string;
  validStart: string;
  validEnd: string;
  forecastHorizonHours: number;
  forecastConfidence: number;
  expectedImpactTime: string;
  uncertaintyNote: string;
  status: "active" | "expired" | "superseded";
}

export interface WarningDecision {
  decisionId: string;
  programId: string;
  hazardType: HazardType;
  forecastId: string;
  decisionTime: string;
  expectedImpactTime: string;
  warningLevel: WarningLevel;
  authority: string;
  protectiveLeadTimeHours: number;
  uncertaintyStatement: string;
  issued: boolean;
  status: "open" | "closed" | "cancelled";
}

export interface EarlyWarningReadinessCard {
  programId: string;
  hazardType: HazardType;
  geography: string;
  forecastConfidence: number;
  riskKnowledge: number;
  protectiveLeadTime: number;
  communicationReach: number;
  actionCapacity: number;
  trustReadiness: number;
  inclusionCapacity: number;
  governanceReadiness: number;
}

export function protectiveLeadTimeHours(warningTimeMs: number, impactTimeMs: number): number {
  return (impactTimeMs - warningTimeMs) / (1000 * 60 * 60);
}

export function requiresGovernanceReview(card: EarlyWarningReadinessCard): boolean {
  return card.governanceReadiness < 0.75 || card.inclusionCapacity < 0.75;
}
