import Then
import Foundation

public struct FlightQuery: Codable, Then {
    public var originPlace: String
    public var destinationPlace: String
    public var outboundDate: String
    public var inboundDate: String
    
    public var origin: Place?
    public var destination: Place?
    
    enum CodingKeys: String, CodingKey
    {
        case originPlace = "OriginPlace"
        case destinationPlace = "DestinationPlace"
        case outboundDate = "OutboundDate"
        case inboundDate = "InboundDate"
    }
}
