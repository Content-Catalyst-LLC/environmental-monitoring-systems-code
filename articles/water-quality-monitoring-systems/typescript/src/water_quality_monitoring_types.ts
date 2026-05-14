export type WaterbodyType =
  | "river"
  | "stream"
  | "lake_reservoir"
  | "groundwater"
  | "source_water"
  | "recreational_water"
  | "wastewater"
  | "stormwater";

export interface WaterQualityObservation {
  siteId: string;
  timestamp: string;
  parameterId: string;
  value: number;
  unit: string;
  methodType: "field_sensor" | "laboratory" | "grab_sample" | "autosampler" | "biological_assessment";
  qualityFlag: "pass" | "review_required" | "suspect" | "excluded";
  hydrologicalContext?: string;
  eventContext?: string;
}

export interface LaboratoryResult {
  labResultId: string;
  sampleId: string;
  siteId: string;
  parameterId: string;
  resultValue: number;
  unit: string;
  methodCode: string;
  detectionLimit: number;
  qualifier?: string;
  labQaqcFlag: "pass" | "review_required" | "suspect" | "excluded";
  resultStatus: "final" | "provisional";
}

export interface WaterQualityReadinessCard {
  programId: string;
  waterbodyType: WaterbodyType;
  decisionUse: string;
  samplingRepresentativeness: number;
  analyticalValidity: number;
  hydrologicalContext: number;
  qaqcCompleteness: number;
  loadReadiness: number;
  thresholdAlignment: number;
  uncertaintyCommunication: number;
  dataInteroperability: number;
  governanceReadiness: number;
}

export function instantaneousLoadKgDay(concentrationMgL: number, dischargeM3S: number): number {
  return concentrationMgL * dischargeM3S * 86.4;
}

export function requiresReview(record: WaterQualityObservation | LaboratoryResult): boolean {
  if ("qualityFlag" in record) {
    return record.qualityFlag !== "pass";
  }
  return record.labQaqcFlag !== "pass";
}
