import Foundation
import RxDataSources
import RxSwift

struct SectionOfResult {
    var header: String
    var items: [Item]
}

extension Itinerary: IdentifiableType {
    public typealias Identity = String
    
    public var identity: Identity {
        return (self.outboundLegId ?? "") + (self.inboundLegId ?? "")
    }
    
}

extension Itinerary: Equatable {
    
    public static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
        return lhs.outboundLegId == rhs.outboundLegId &&
            lhs.inboundLegId == rhs.inboundLegId
    }
    
}

extension SectionOfResult: AnimatableSectionModelType {
    
    typealias Item = Itinerary
    
    typealias Identity = String
    
    var identity: Identity {
        return items.reduce("", { (acum, cat) -> String in
            return "\(acum)\(cat)"
        })
    }
    
    init(original: SectionOfResult, items: [Itinerary]) {
        self = original
        self.items = items
    }
    
}
