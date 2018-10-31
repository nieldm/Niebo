import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var segmentStackView: UIStackView!

    func set(data: Itinerary) {
        if let pricing = data.pricingOptions.first, let currency = data.currency {
            let currencyFormatter = NumberFormatter().then {
                $0.usesGroupingSeparator = true
                $0.numberStyle = .currency
                $0.currencySymbol = currency.symbol
                $0.currencyDecimalSeparator = currency.decimalSeparator
                $0.currencyGroupingSeparator = currency.thousandsSeparator
                $0.currencyCode = currency.code
            }
            if let priceString = currencyFormatter.string(from: NSNumber(value: pricing.price)) {
                self.priceLabel.text = priceString
            }
        }
        if let leg = data.outbound {
            self.addLeg(data: leg)
        }
        if let leg = data.inbound {
            self.addLeg(data: leg)
        }
    }
    
    private func addLeg(data: FlightLeg) {
        let _ = SegmentView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 70)).then {
            self.segmentStackView.addArrangedSubview($0)
            $0.createConstraints()
            $0.set(data: data)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.segmentStackView.arrangedSubviews.forEach { [weak self] view in
            self?.segmentStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
