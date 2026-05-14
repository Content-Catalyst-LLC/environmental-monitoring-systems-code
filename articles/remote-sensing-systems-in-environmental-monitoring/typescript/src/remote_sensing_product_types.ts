export type EvidenceStatus =
  | "measured_signal"
  | "corrected_product"
  | "index_product"
  | "retrieved_product"
  | "classified_product"
  | "modeled_output"
  | "decision_product";

export interface RemoteSensingProductCard {
  productId: string;
  platformId: string;
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

export interface PlatformSensorCard {
  platformId: string;
  platformType: string;
  sensingMode: string;
  revisitCategory: string;
  coverageScope: string;
  primaryDomains: string[];
}

export function requiresCaveat(product: RemoteSensingProductCard): boolean {
  if (product.evidenceStatus !== "measured_signal" && !product.uncertaintyLabel) return true;
  if (!product.validUseStatement) return true;
  if (!product.productVersion) return true;
  return false;
}
