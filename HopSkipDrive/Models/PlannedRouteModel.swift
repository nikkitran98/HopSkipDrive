struct PlannedRoute: Codable {
    let id: Int
    let total_time: Double
    let total_distance: Int
    let starts_at: String
    let ends_at: String
    let legs: [Leg]
}
