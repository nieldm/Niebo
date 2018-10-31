import Foundation
import Then
import CoreData

public struct Itinerary: Codable, Then {
    public var outboundLegId: String
    public var inboundLegId: String
    public var pricingOptions: [PricingOption]
    public var outbound: FlightLeg?
    public var inbound: FlightLeg?
    public var currency: Currency?
    
    enum CodingKeys: String, CodingKey
    {
        case outboundLegId = "OutboundLegId"
        case inboundLegId = "InboundLegId"
        case pricingOptions = "PricingOptions"
    }
}
