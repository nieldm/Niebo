import Foundation
import NieboFramework
import Moya

let model = PricingModel(mocked: true)
let _ = model.rx.initSession
    .subscribe(onNext: { result in
        print(result.status)
        let first = result.itineraries.first
        print(first?.legId)
        print(first?.leg)
//        let agent = result.agent(id: first?.pricingOptions.first?.agents.first ?? 0)
//        print(agent?.name)
    })

