//: [Previous](@previous)

import Foundation
import NieboFramework

let model = PricingModel(mocked: true)
let _ = model.rx.initSession
    .map { $0.compose() }
    .subscribe(onNext: { query in
        let cheapest = query.itineraries.sorted(by: { (lhs: Itinerary, rhs: Itinerary) -> Bool in

            return lhs.price < rhs.price
        }).first
        cheapest?.price
        let shortest = query.itineraries.sorted(by: { (lhs: Itinerary, rhs: Itinerary) -> Bool in
            
            return lhs.duration < rhs.duration
        }).first
        shortest?.duration
    })

//: [Next](@next)
