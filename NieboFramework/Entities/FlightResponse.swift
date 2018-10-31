import Foundation
import Then

public enum Status: String, Codable {
    case pending = "UpdatesPending"
    case complete = "UpdatesComplete"
    case other
}

public struct FlightResponse: Codable, Then {
    public var status: Status = .other
    public var query: FlightQuery
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
        case query = "Query"
        case itineraries = "Itineraries"
        case legs = "Legs"
        case segments = "Segments"
        case carriers = "Carriers"
        case agents = "Agents"
        case places = "Places"
        case currencies = "Currencies"
    }
    
    public func compose() -> FlightResponse {
        return self.with { response in
            response.query = self.query.with { mutableQuery in
                mutableQuery.origin = self.places.filter { self.query.originPlace == "\($0.id)" }.first
                mutableQuery.destination = self.places.filter { self.query.destinationPlace == "\($0.id)" }.first
            }
            response.segments = response.segments.map { segment in
                return segment.with { mutableSegment in
                    mutableSegment.carrier = response.carriers.filter { segment.carrierId == $0.id }.first
                    mutableSegment.origin = response.places.filter { segment.originId == $0.id }.first
                    mutableSegment.destination = response.places.filter { segment.destinationId == $0.id }.first
                }
            }
            response.legs = response.legs.map { leg in
                return leg.with { mutableLeg in
                    mutableLeg.origin = response.places.filter { leg.originStation == $0.id }.first
                    mutableLeg.destination = response.places.filter { leg.destinationStation == $0.id }.first
                    mutableLeg.carriers = response.carriers.filter { leg.carrierIds.contains($0.id) }
                    mutableLeg.segments = response.segments.filter { leg.segmentIds.contains($0.id) }
                    mutableLeg.stops = response.places.filter { leg.stopIds.contains($0.id) }
                    mutableLeg.flightNumbers = leg.flightNumbers.map { fnumber in
                        return fnumber.with { mutableFnumber in
                            mutableFnumber.carrier = response.carriers.filter { fnumber.carrierId == $0.id }.first
                        }
                    }
                }
            }
            response.itineraries = response.itineraries.map { itinerary in
                return itinerary.with { mutableItinerary in
                    mutableItinerary.currency = response.currencies.first
                    mutableItinerary.inbound = response.legs.filter { $0.id == itinerary.inboundLegId }.first
                    mutableItinerary.outbound = response.legs.filter { $0.id == itinerary.outboundLegId }.first
                    mutableItinerary.pricingOptions = itinerary.pricingOptions.map { option in
                        return option.with { mutableOption in
                            mutableOption.agents = response.agents.filter { agent -> Bool in
                                return option.agentIds.contains(agent.id)
                            }
                        }
                    }
                }
            }
        }
    }
}
