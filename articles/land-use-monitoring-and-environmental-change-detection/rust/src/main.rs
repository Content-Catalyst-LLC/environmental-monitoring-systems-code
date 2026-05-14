fn main() {
    let required_land_change_fields = [
        "change_id",
        "product_id",
        "geography",
        "from_class",
        "to_class",
        "change_type",
        "change_year",
        "confidence",
        "persistence_score",
        "validated",
        "reporting_relevance",
    ];

    println!("Land-change record validator scaffold");
    println!("Required land-change fields:");
    for field in required_land_change_fields {
        println!("- {}", field);
    }
}
