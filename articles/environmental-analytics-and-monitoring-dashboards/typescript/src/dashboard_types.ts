export type EvidenceType = "measured" | "modeled" | "estimated" | "interpolated" | "administrative";

export interface DashboardIndicator {
  indicatorId: string;
  label: string;
  domain: string;
  unit: string;
  value: number | null;
  evidenceType: EvidenceType;
  lastUpdated: string;
  hasProvenance: boolean;
  uncertaintyLabel?: string;
  severity?: "normal" | "watch" | "warning" | "critical" | "quality";
}

export interface ProvenanceRecord {
  sourceId: string;
  sourceType: string;
  owner: string;
  timestamp: string;
  transformationMethod: string;
  processingVersion: string;
  qualityFlag?: string;
}

export function requiresReview(indicator: DashboardIndicator): boolean {
  if (!indicator.hasProvenance) return true;
  if (indicator.evidenceType !== "measured" && !indicator.uncertaintyLabel) return true;
  return indicator.severity === "warning" || indicator.severity === "critical" || indicator.severity === "quality";
}
