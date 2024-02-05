struct Leg: Codable {
    let id: Int
    let starts_at: String
    let ends_at: String
    let position: Int
    let start_waypoint_id: Int
    let end_waypoint_id: Int
}
