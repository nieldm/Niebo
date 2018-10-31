import Foundation
import RxSwift

public class ResultsViewModel: ReactiveCompatible {
    
    fileprivate let query = ReplaySubject<FlightResponse>.create(bufferSize: 1)
    
    private let model: PricingModel
    private let disposeBag = DisposeBag()
    
    public init(model: PricingModel) {
        self.model = model
        self.start()
    }
    
    //Mocked Init
    public convenience init() {
        self.init(model: PricingModel(mocked: false))
    }
    
    private func start() {
        self.model.rx.initSession
            .subscribe(onNext: {
                self.query.onNext($0)
            })
            .disposed(by: self.disposeBag)
    }
    
    func change(sort: SortOption?, modifier: SortModifier?, filter: FilterOption?) {
        self.model.rx.change(sortOption: sort, sortModifier: modifier, filter: filter)
            .subscribe(onNext: {
                self.query.onNext($0)
            })
            .disposed(by: self.disposeBag)
    }
}

public extension Reactive where Base == ResultsViewModel {
    
    var results: Observable<FlightResponse> {
        return self.base.query
    }
    
}
