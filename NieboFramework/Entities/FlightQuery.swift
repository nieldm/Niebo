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
    
    public func compose() -> FlightQuery {
        return self.with { query in
            query.segments = query.segments.map { segment in
                return segment.with { mutableSegment in
                    mutableSegment.carrier = query.carriers.filter { segment.carrierId == $0.id }.first
                    mutableSegment.origin = query.places.filter { segment.originId == $0.id }.first
                    mutableSegment.destination = query.places.filter { segment.destinationId == $0.id }.first
                }
            }
            query.legs = query.legs.map { leg in
                return leg.with { mutableLeg in
                    mutableLeg.segments = query.segments.filter { leg.segmentIds.contains($0.id) }
                    mutableLeg.stops = query.places.filter { leg.stopIds.contains($0.id) }
                    mutableLeg.flightNumbers = leg.flightNumbers.map { fnumber in
                        return fnumber.with { mutableFnumber in
                            mutableFnumber.carrier = query.carriers.filter { fnumber.carrierId == $0.id }.first
                        }
                    }
                }
            }
            query.itineraries = query.itineraries.map { itinerary in
                return itinerary.with { mutableItinerary in
                    mutableItinerary.currency = query.currencies.first
                    mutableItinerary.leg = query.legs.filter { $0.id == itinerary.legId }.first
                    mutableItinerary.pricingOptions = itinerary.pricingOptions.map { option in
                        return option.with { mutableOption in
                            mutableOption.agents = query.agents.filter { agent -> Bool in
                                return option.agentIds.contains(agent.id)
                            }
                        }
                    }
                }
            }
        }
    }
}
