import UIKit
import SnapKit
import RxDataSources
import RxCocoa
import RxSwift

public class ResultsViewController: UIViewController {

    private let viewModel: ResultsViewModel
    private var header: UIView!
    private var leftNavButton: UIButton!
    private var rightNavButton: UIButton!
    private var collectionView: UICollectionView! {
        didSet {
            self.configureCollectionView()
        }
    }
    private var titleLabel: UILabel!
    private var subTitleLabel: UILabel!
    private var totalResultsLabel: UILabel!
    private var sortButton: UIButton!
    private var filterButton: UIButton!
    private var activityIndicator: UIActivityIndicatorView!
    private var shareText: String = ""
    
    private let disposeBag = DisposeBag()
    private var itemHeights: [CGFloat] = []
    
    private var lastSortOption: SortOption?
    private var lastSortModifier: SortModifier?
    private var lastFilter: FilterOption?
    
    public init(viewModel: ResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init() {
        self.init(viewModel: ResultsViewModel())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayBG
        
        let header = UIView(frame: .zero).then {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(87 + UIApplication.shared.statusBarFrame.height)
                
            }
            $0.layer.shadowColor = UIColor.dusk36.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 3)
            $0.layer.shadowOpacity = 0.36
            $0.backgroundColor = .white
        }
        self.header = header
        
        let leftNavButton = UIButton(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.size.equalTo(44)
                make.top.equalTo(header.snp.topMargin)
                make.left.equalToSuperview().inset(6)
            }
            let bundle = Bundle(for: ResultsViewController.self)
            let image = UIImage(named: "backIcon", in: bundle, compatibleWith: nil)
            $0.setImage(image, for: .normal)
        }
        self.leftNavButton = leftNavButton
        
        let rightNavButton = UIButton(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.size.equalTo(44)
                make.top.equalTo(header.snp.topMargin)
                make.right.equalToSuperview().inset(6)
            }
            let bundle = Bundle(for: ResultsViewController.self)
            let image = UIImage(named: "icActionShare", in: bundle, compatibleWith: nil)
            $0.setImage(image, for: .normal)
        }
        self.rightNavButton = rightNavButton
        
        let titleLabel = UILabel(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.left.equalTo(leftNavButton.snp.right)
                make.right.equalTo(rightNavButton.snp.left)
                make.centerY.equalTo(leftNavButton.snp.centerY)
            }
            $0.textAlignment = .center
            $0.text = "London to Madrid"
            $0.textColor = .dusk
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
        self.titleLabel = titleLabel
        
        let subTitleLabel = UILabel(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom)
                make.width.equalTo(titleLabel)
                make.centerX.equalTo(titleLabel)
            }
            $0.textAlignment = .center
            $0.text = "Mar 01., Wed – Mar 05., Sun"
            $0.textColor = .purpleyGrey
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.subTitleLabel = subTitleLabel
        
        let totalResultsLabel = UILabel(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(subTitleLabel.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(16)
                make.right.equalTo(header.snp.centerX)
            }
            $0.textAlignment = .left
            $0.text = "365 of 365 results shown"
            $0.textColor = .purpleyGrey
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.totalResultsLabel = totalResultsLabel
        
        let filterButton = UIButton(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(16)
                make.bottom.equalTo(totalResultsLabel.snp.bottom)
                make.width.equalTo(30)
                make.height.equalTo(14)
            }
            $0.setTitle("Filter", for: .normal)
            $0.setTitleColor(.turquoiseBlue, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.filterButton = filterButton
        
        let sortButton = UIButton(frame: .zero).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.right.equalTo(filterButton.snp.left).inset(-16)
                make.bottom.equalTo(filterButton.snp.bottom)
                make.width.equalTo(30)
                make.height.equalTo(14)
            }
            $0.setTitle("Sort", for: .normal)
            $0.setTitleColor(.turquoiseBlue, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.sortButton = sortButton
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            self.view.insertSubview($0, belowSubview: header)
            $0.snp.makeConstraints { make in
                make.top.equalTo(header.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            $0.backgroundColor = .lightGrayBG
            let bundle = Bundle(for: ResultsViewController.self)
            $0.register(UINib(nibName: "ResultsCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "Cell")
            $0.showsVerticalScrollIndicator = false
            $0.keyboardDismissMode = .onDrag
        }
        self.collectionView = collectionView
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge).then {
            header.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel.snp.bottom)
                make.centerX.equalToSuperview()
            }
            $0.hidesWhenStopped = true
            $0.color = .dusk
            $0.startAnimating()
        }
        self.activityIndicator = activityIndicator
        
        self.rxBind()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let showBackButton = self.navigationController?.viewControllers.count ?? 0 > 1
        self.leftNavButton.isHidden = !showBackButton
    }
    
    private func configureCollectionView() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfResult>(configureCell: { (_, cv: UICollectionView, ip: IndexPath, item: Itinerary) -> UICollectionViewCell in
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: ip) as? ResultsCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell.then {
                $0.set(data: item)
                $0.backgroundColor = .white
            }
        })
        self.viewModel.rx.results
            .debug("Results")
            .map { [SectionOfResult(header: "Itinerary", items: $0.itineraries)] }
            .bind(to: self.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        let _ = self.collectionView.rx.setDelegate(self)
    }
    
    private func rxBind() {
        self.viewModel.rx.results
            .map { $0.itineraries.count }
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] count in
                self?.totalResultsLabel.text = "\(count) results shown"
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.rx.results
            .map { $0.itineraries }
            .subscribe(onNext: { [weak self] data in
                self?.itemHeights = data.map { itinerary -> CGFloat in
                    var spaces = 0
                    if let _ = itinerary.outbound {
                        spaces += 1
                    }
                    if let _ = itinerary.inbound {
                        spaces += 1
                    }
                    let totalHeight = (70 * spaces) + 60
                    return CGFloat(totalHeight)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.rx.results
            .map { results -> String in
                guard let from = results.query.origin,
                    let to = results.query.destination else {
                    return ""
                }
                return "\(from.name) to \(to.name)"
            }
            .do(onNext: { [weak self] text in
                self?.shareText = "Hey, im looking for flights from \(text) in skyscanner"
            })
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.rx.results
            .map { results -> String in
                guard let from = results.query.outboundDate.dateNoTimeZone?.monthDayAndDayOfTheWeek,
                    let to = results.query.inboundDate.dateNoTimeZone?.monthDayAndDayOfTheWeek else {
                        return ""
                }
                return "\(from) - \(to)"
            }
            .bind(to: self.subTitleLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.sortButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.rx.showSortAlert()
                    .subscribe(onNext: { [weak self] result in
                        self?.selectSort(option: result.0, modifier: result.1)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: self.disposeBag)
        
        self.filterButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.rx.showFilterAlert()
                    .subscribe(onNext: { [weak self] result in
                        self?.select(filter: result)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.rx.state
            .asDriver(onErrorJustReturn: .loading)
            .drive(onNext: { state in
                switch state {
                case .loading:
                    self.changeHeaderVisibility(show: false)
                case .done:
                    self.changeHeaderVisibility(show: true)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.rightNavButton.rx.tap
            .asDriver()
            .drive(onNext: {
                if let url = URL(string: "https://www.skyscanner.net") {
                    UIActivityViewController(activityItems: [self.shareText, url], applicationActivities: nil).do {
                        self.present($0, animated: true)
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func changeHeaderVisibility(show: Bool) {
        self.header.subviews.forEach { $0.isHidden = !show }
        self.activityIndicator.isHidden = false
        self.leftNavButton.isHidden = true
        if show {
            self.activityIndicator.stopAnimating()
        } else {
            self.activityIndicator.startAnimating()
        }
    }

    private func selectSort(option: SortOption?, modifier: SortModifier?) {
        self.lastSortOption = option
        self.lastSortModifier = modifier
        self.updateSortAndFilters()
    }
    
    private func select(filter: FilterOption?) {
        self.lastFilter = filter
        self.updateSortAndFilters()
    }
    
    private func updateSortAndFilters() {
        self.viewModel.change(
            sort: self.lastSortOption,
            modifier: self.lastSortModifier,
            filter: self.lastFilter
        )
    }
    
}

fileprivate extension Reactive where Base == ResultsViewController {
    func showFilterAlert() -> Observable<FilterOption?> {
        return Observable.create { observer in
            let alert = UIAlertController(title: "Filter", message: "Select a filter option", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Direct Flights", style: UIAlertAction.Style.default) { _ in
                observer.onNext(FilterOption.direct)
                observer.onCompleted()
            })
            alert.addAction(UIAlertAction(title: "Clear", style: UIAlertAction.Style.default) { _ in
                observer.onNext(nil)
                observer.onCompleted()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
                observer.onCompleted()
            })
            self.base.present(alert, animated: true)
            return Disposables.create()
        }
    }
    
    func showSortAlert() -> Observable<(SortOption?, SortModifier?)> {
        return Observable.create { observer in
            let alert = UIAlertController(title: "Sort", message: "Select a sort option", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Price ASC", style: UIAlertAction.Style.default, handler: { (action) in
                observer.onNext((SortOption.price, SortModifier.ascendant))
                observer.onCompleted()
            }))
            alert.addAction(UIAlertAction(title: "Price DESC", style: UIAlertAction.Style.default, handler: { (action) in
                observer.onNext((SortOption.price, SortModifier.descendant))
                observer.onCompleted()
            }))
            alert.addAction(UIAlertAction(title: "Duration ASC", style: UIAlertAction.Style.default, handler: { (action) in
                observer.onNext((SortOption.duration, SortModifier.ascendant))
                observer.onCompleted()
            }))
            alert.addAction(UIAlertAction(title: "Duration DESC", style: UIAlertAction.Style.default, handler: { (action) in
                observer.onNext((SortOption.duration, SortModifier.descendant))
                observer.onCompleted()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
            self.base.present(alert, animated: true)
            return Disposables.create()
        }
    }
}

extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: self.itemHeights[indexPath.row]
        )
    }
    
}
