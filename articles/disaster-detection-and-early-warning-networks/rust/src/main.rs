fn main() {
    let required_message_fields = [
        "template_id",
        "hazard_type",
        "severity",
        "audience",
        "message_goal",
        "action_text",
    ];

    println!("Early warning message-template validator scaffold");
    println!("Required message-template fields:");
    for field in required_message_fields {
        println!("- {}", field);
    }
}
