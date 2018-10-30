import UIKit
import SnapKit

public class ResultsViewController: UIViewController {

    private var leftNavButton: UIButton!
    
    public init() {
        super.init(nibName: nil, bundle: nil)
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
        
        let tableView = UITableView(frame: .zero, style: .grouped).then {
            self.view.insertSubview($0, belowSubview: header)
            $0.snp.makeConstraints { make in
                make.top.equalTo(header.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
            $0.backgroundColor = .lightGrayBG
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let showBackButton = self.navigationController?.viewControllers.count ?? 0 > 1
        self.leftNavButton.isHidden = !showBackButton
    }

}
