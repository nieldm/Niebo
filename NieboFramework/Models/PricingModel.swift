import Foundation
import Moya
import RxSwift

public class PricingModel: ReactiveCompatible {
    
    public var api: MoyaProvider<SKYPricesAPI>
    
    public init(mocked: Bool = false) {
        if CommandLine.arguments.contains("-mock-services") || mocked {
            self.api = MoyaProvider<SKYPricesAPI>(
                endpointClosure: PricingModel.createCustomEndpoint,
                requestClosure: MoyaProvider.defaultRequestMapping,
                stubClosure: MoyaProvider.immediatelyStub
            )
        } else {
            self.api = MoyaProvider<SKYPricesAPI>()
        }
    }
    
    private class func createCustomEndpoint(target: SKYPricesAPI) -> Endpoint<SKYPricesAPI> {
        let url = (target.baseURL.absoluteString + target.path)
        let sampleResponseClosure = { () -> (EndpointSampleResponse) in
            switch target {
            case .pricing:
                let response = HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: nil, headerFields: ["Location": "http://partners.api.skyscanner.net/apiservices/pricing/uk1/v1.0/c37f63f5-ce5d-492d-9745-195160539936"])!
                return EndpointSampleResponse.response(response, target.sampleData)
            default:
                return EndpointSampleResponse.networkResponse(200, target.sampleData)
            }
        }
        return Endpoint(url: url, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    
}

public extension Reactive where Base == PricingModel {
    
    var initSession: Observable<FlightResponse> {
        return self.base.api.rx.request(SKYPricesAPI.pricing)
            .flatMap { (response) -> PrimitiveSequence<SingleTrait, Response> in
                let location = response.response?.allHeaderFields["Location"] as? String
                return self.base.api.rx.request(SKYPricesAPI.results(url: location, pageIndex: 0))
            }
            .map(FlightResponse.self)
            .map { $0.compose() }
            .asObservable()
    }
    
}

extension TargetType {
    var url: String {
        return (self.baseURL.absoluteString + self.path)
    }
}
