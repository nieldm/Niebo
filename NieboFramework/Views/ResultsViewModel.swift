import Foundation
import RxSwift

public class ResultsViewModel: ReactiveCompatible {
    
    fileprivate let query = ReplaySubject<FlightQuery>.create(bufferSize: 1)
    
    private let model: PricingModel
    private let disposeBag = DisposeBag()
    
    public init(model: PricingModel) {
        self.model = model
        self.start()
    }
    
    //Mocked Init
    public convenience init() {
        self.init(model: PricingModel(mocked: true))
    }
    
    private func start() {
        self.model.rx.initSession
            .subscribe(self.query)
            .disposed(by: self.disposeBag)
    }
    
}

public extension Reactive where Base == ResultsViewModel {
    
    var results: Observable<FlightQuery> {
        return self.base.query
    }
    
}
