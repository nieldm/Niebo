import Foundation
import Then

public enum Directionality: String, Codable {
    case outbound = "Outbound"
    case inbound = "Inbound"
}

public struct Segment: Codable, Then {
    public var id: Int
    public var originId: Int
    public var destinationId: Int
    public var departure: String
    public var arrival: String
    public var carrierId: Int
    public var operationCarrier: Int
    public var duration: Int
    public var flightNumber: String
    public var mode: JourneyMode = .other
    public var directionality: Directionality
    
    public var carrier: Carrier?
    public var origin: Place?
    public var destination: Place?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "Id"
        case originId = "OriginStation"
        case destinationId = "DestinationStation"
        case departure = "DepartureDateTime"
        case arrival = "ArrivalDateTime"
        case carrierId = "Carrier"
        case operationCarrier = "OperatingCarrier"
        case duration = "Duration"
        case flightNumber = "FlightNumber"
        case mode = "JourneyMode"
        case directionality = "Directionality"
    }
}
