fn main() {
    let required_product_fields = [
        "product_id",
        "platform_id",
        "domain",
        "sensing_mode",
        "product_type",
        "processing_level",
        "variable",
        "unit",
        "temporal_cadence",
        "spatial_scale",
        "evidence_status",
        "decision_use",
    ];

    println!("Remote-sensing product metadata validator scaffold");
    println!("Required remote-sensing product fields:");
    for field in required_product_fields {
        println!("- {}", field);
    }
}
