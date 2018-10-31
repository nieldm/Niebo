import Foundation
import RxSwift

public enum DataState {
    case loading, done
}

public class ResultsViewModel: ReactiveCompatible {
    
    fileprivate let query = ReplaySubject<FlightResponse>.create(bufferSize: 1)
    fileprivate let state = BehaviorSubject<DataState>(value: .loading)
    
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
            .do(onNext: { _ in
                self.state.onNext(.done)
            }, onError: { _ in
                self.state.onNext(.done)
            })
            .subscribe(onNext: {
                self.query.onNext($0)
            })
            .disposed(by: self.disposeBag)
    }
    
    func change(sort: SortOption?, modifier: SortModifier?, filter: FilterOption?) {
        self.state.onNext(.loading)
        self.model.rx.change(sortOption: sort, sortModifier: modifier, filter: filter)
            .do(onNext: { _ in
                self.state.onNext(.done)
            }, onError: { _ in
                self.state.onNext(.done)
            })
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
    
    var state: Observable<DataState> {
        return self.base.state
    }
    
}
