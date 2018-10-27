import Foundation

public enum JourneyMode: String, Codable {
    case flight = "Flight"
    case other
}

public struct FlightLeg: Codable {
    public var id: String
    public var departure: String
    public var arrival: String
    public var duration: Int
    public var journeyMode: JourneyMode = .other
    public var segments: [Int]
    public var stops: [Int]
    public var carriers: [Int]
    public var directionality: String
    public var flightNumbers: [FlightNumber]
    
    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case departure = "Departure"
        case arrival = "Arrival"
        case segments = "SegmentIds"
        case stops = "Stops"
        case carriers = "Carriers"
        case directionality = "Directionality"
        case flightNumbers = "FlightNumbers"
        case duration = "Duration"
        case journeyMode = "JourneyMode"
    }
}
