import Foundation
import Then
import CoreData

public struct Itinerary: Codable, Then {
    public var legId: String
    public var pricingOptions: [PricingOption]
    public var leg: FlightLeg?
    public var currency: Currency?
    
    enum CodingKeys: String, CodingKey
    {
        case legId = "OutboundLegId"
        case pricingOptions = "PricingOptions"
    }
}
