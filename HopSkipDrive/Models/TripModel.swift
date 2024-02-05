struct Trip: Codable {
    let carpool: Bool
    let driver_can_cancel: Bool
    let driver_fare_multiplier: Int
    let estimated_earnings: Int
    let estimated_net_earnings: Int
    let id: Int
    let state: String
    let time_anchor: String
    let updated_at: String
    let time_zone_name: String
    let uuid: String
    let planned_route: PlannedRoute
    let in_series: Bool?
    let passengers: [Passenger]
    let waypoints: [Waypoint]
}
