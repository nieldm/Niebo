import Foundation
import Then

public enum Status: String, Codable {
    case pending = "UpdatesPending"
    case complete = "UpdatesComplete"
    case other
}

public struct FlightQuery: Codable, Then {
    public var status: Status = .other
    public var itineraries: [Itinerary]
    public var legs: [FlightLeg]
    public var segments: [Segment]
    public var carriers: [Carrier]
    public var agents: [Agent]
    public var places: [Place]
    public var currencies: [Currency]
    
    enum CodingKeys: String, CodingKey
    {
        case status = "Status"
        case itineraries = "Itineraries"
        case legs = "Legs"
        case segments = "Segments"
        case carriers = "Carriers"
        case agents = "Agents"
        case places = "Places"
        case currencies = "Currencies"
    }
    
//    public init(from decoder: Decoder) throws
//    {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.status = try values.decode(Status.self, forKey: .status)
//        let itineraries = try values.decode(Array<Itinerary>.self, forKey: .itineraries)
//        let legs = try values.decode(Array<FlightLeg>.self, forKey: .legs)
//        self.itineraries = itineraries
//    }
    
//    public func compose() -> FlightQuery {
//        return self.with { query in
//            query.itineraries = query.itineraries.map { itinerary in
//                return itinerary.with { mutableItinerary in
//                    mutableItinerary.leg = self.legs.filter { $0.id == itinerary.legId }.first
//                    mutableItinerary.pricingOptions = itinerary.pricingOptions.map { option in
//                        return option.with { mutableOption in
//                            mutableOption.agents = self.agents.filter { agent -> Bool in
//                                return option.agentIds.contains(agent.id)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}
