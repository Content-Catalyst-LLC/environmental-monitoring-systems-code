type MonitoringSummary = {
  domain: string;
  records: number;
  meanSignalQuality: number;
  validRecordRate: number;
};

const summaries: MonitoringSummary[] = [
  { domain: "air_quality", records: 2, meanSignalQuality: 0.975, validRecordRate: 1.0 },
  { domain: "water_quality", records: 1, meanSignalQuality: 0.91, validRecordRate: 1.0 },
  { domain: "soil_monitoring", records: 1, meanSignalQuality: 0.76, validRecordRate: 0.0 },
];

for (const summary of summaries) {
  console.log(
    `${summary.domain}: records=${summary.records}, signal=${summary.meanSignalQuality}, valid=${summary.validRecordRate}`
  );
}
