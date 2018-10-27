import Foundation

public enum Directionality: String, Codable {
    case outbound = "Outbound"
    case inbound = "Inbound"
}

public struct Segment: Codable {
    public var id: Int
    public var origin: Int
    public var destination: Int
    public var departure: String
    public var arrival: String
    public var carrier: Int
    public var operationCarrier: Int
    public var duration: Int
    public var flightNumber: String
    public var mode: JourneyMode = .other
    public var directionality: Directionality
    
    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case origin = "OriginStation"
        case destination = "DestinationStation"
        case departure = "DepartureDateTime"
        case arrival = "ArrivalDateTime"
        case carrier = "Carrier"
        case operationCarrier = "OperatingCarrier"
        case duration = "Duration"
        case flightNumber = "FlightNumber"
        case mode = "JourneyMode"
        case directionality = "Directionality"
    }
}
