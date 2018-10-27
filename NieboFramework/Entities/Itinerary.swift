import Foundation
import Then
import CoreData

public final class NItinerary: NSManagedObject {
    @NSManaged fileprivate(set) var outboundLegId: String
    
    public static func insert(into context: NSManagedObjectContext, legId: String) -> NItinerary {
        let itinerary: NItinerary = context.insertObject()
        itinerary.outboundLegId = legId
        return itinerary
    }
}

extension NItinerary: Managed {
    
}

public struct Itinerary: Codable, Then {
    public var legId: String
    public var pricingOptions: [PricingOption]
    public var leg: FlightLeg?
    
    enum CodingKeys: String, CodingKey
    {
        case legId = "OutboundLegId"
        case pricingOptions = "PricingOptions"
    }
}
