import Then
import Foundation

public enum JourneyMode: String, Codable {
    case flight = "Flight"
    case other
}

public struct FlightLeg: Codable, Then {
    public var id: String
    public var departure: String
    public var arrival: String
    public var duration: Int
    public var journeyMode: JourneyMode = .other
    public var segmentIds: [Int]
    public var stopIds: [Int]
    public var carrierIds: [Int]
    public var directionality: String
    public var flightNumbers: [FlightNumber]
    public var originStation: Int
    public var destinationStation: Int
    
    public var segments: [Segment] = []
    public var stops: [Place] = []
    public var carriers: [Carrier] = []
    public var origin: Place?
    public var destination: Place?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case departure = "Departure"
        case arrival = "Arrival"
        case segmentIds = "SegmentIds"
        case stopIds = "Stops"
        case carrierIds = "Carriers"
        case directionality = "Directionality"
        case flightNumbers = "FlightNumbers"
        case duration = "Duration"
        case journeyMode = "JourneyMode"
        case originStation = "OriginStation"
        case destinationStation = "DestinationStation"
    }
}
