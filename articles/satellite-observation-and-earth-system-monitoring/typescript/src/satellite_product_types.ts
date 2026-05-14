export type EvidenceStatus =
  | "measured_signal"
  | "retrieved_product"
  | "classified_product"
  | "modeled_output"
  | "scenario_output"
  | "decision_product";

export interface SatelliteProductCard {
  productId: string;
  missionId: string;
  title: string;
  domain: string;
  sensingMode: string;
  productType: string;
  processingLevel: string;
  variable: string;
  unit: string;
  temporalCadence: string;
  spatialScale: string;
  evidenceStatus: EvidenceStatus;
  productVersion?: string;
  uncertaintyLabel?: string;
  qualityFlag?: string;
  validUseStatement?: string;
}

export interface MissionCard {
  missionId: string;
  agency: string;
  orbitType: string;
  revisitCategory: string;
  coverageScope: string;
  primaryDomains: string[];
}

export function requiresCaveat(product: SatelliteProductCard): boolean {
  if (product.evidenceStatus !== "measured_signal" && !product.uncertaintyLabel) return true;
  if (!product.validUseStatement) return true;
  if (!product.productVersion) return true;
  return false;
}
