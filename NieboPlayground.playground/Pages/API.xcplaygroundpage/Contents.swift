//: [Previous](@previous)

import Foundation
import NieboFramework
import Moya

let model = PricingModel(mocked: true)
let _ = model.rx.initSession
    .subscribe(onNext: { result in
        print(result)
    })


//: [Next](@next)
