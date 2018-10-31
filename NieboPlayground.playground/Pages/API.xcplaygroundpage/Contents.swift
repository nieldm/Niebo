import Foundation
import NieboFramework
import Moya

let model = PricingModel(mocked: true)
let _ = model.rx.initSession
    .subscribe(onNext: { result in
        let query = result.compose()
        guard let itinerary = query.itineraries.first else { return }
        guard let outbound = itinerary.outbound else { return }
        print("Segments \(outbound.segments.count)")
        guard let segment = outbound.segments.first else { return }
        segment.origin
        segment.destination
        guard let carrier = segment.carrier else { return }
        print("Carrier \(carrier.displayCode)")
    })

