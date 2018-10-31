import Foundation
import Then
import CoreData

public struct Itinerary: Codable, Then {
    public var outboundLegId: String?
    public var inboundLegId: String?
    public var pricingOptions: [PricingOption]
    public var outbound: FlightLeg?
    public var inbound: FlightLeg?
    public var currency: Currency?
    
    public var cheapest: Bool = false
    public var shortest: Bool = false
    
    public var price: Float {
        return self.pricingOptions.first?.price ?? 0
    }
    
    public var duration: Int {
        return (self.outbound?.duration ?? 0) + (self.inbound?.duration ?? 0)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case outboundLegId = "OutboundLegId"
        case inboundLegId = "InboundLegId"
        case pricingOptions = "PricingOptions"
    }
}
