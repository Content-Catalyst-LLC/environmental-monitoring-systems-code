export type EvidenceStatus =
  | "measured"
  | "modeled"
  | "estimated"
  | "interpolated"
  | "forecast"
  | "scenario"
  | "administrative";

export interface EnvironmentalDatasetCard {
  assetId: string;
  title: string;
  domain: string;
  assetType: string;
  sourceId: string;
  owner: string;
  unit?: string;
  temporalScope: string;
  spatialReference?: string;
  evidenceStatus: EvidenceStatus;
  provenanceUrl?: string;
  uncertaintyLabel?: string;
  lastUpdated?: string;
}

export interface DecisionSupportView {
  viewId: string;
  userRole: string;
  priorityQuestion: string;
  requiredEvidence: string[];
  actionPathway: string;
  publicFacing: boolean;
}

export function requiresGovernanceReview(dataset: EnvironmentalDatasetCard): boolean {
  if (!dataset.provenanceUrl) return true;
  if (dataset.evidenceStatus !== "measured" && !dataset.uncertaintyLabel) return true;
  if (!dataset.lastUpdated) return true;
  return false;
}
