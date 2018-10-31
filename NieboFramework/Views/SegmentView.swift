import UIKit
import AlamofireImage

public class SegmentView: UIView {
    
    private var iconView: UIImageView!
    private var timeLabel: UILabel!
    private var infoLabel: UILabel!
    private var segmentDirectLabel: UILabel!
    private var durationLabel: UILabel!
    
    func createConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.left.right.equalToSuperview()
        }
        
        let iconView = UIImageView(frame: .zero).then {
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.size.equalTo(31)
                make.left.equalToSuperview().offset(16)
                make.centerY.equalToSuperview()
            }
            $0.contentMode = .scaleAspectFit
        }
        self.iconView = iconView
        
        let timeLabel = UILabel(frame: .zero).then {
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.bottom.equalTo(self.snp.centerY).offset(4)
                make.left.equalTo(iconView.snp.right).offset(16)
            }
            $0.text = "15:35 - 17:00"
            $0.textAlignment = .left
            $0.textColor = .dusk
            $0.font = .systemFont(ofSize: 16, weight: .regular)
        }
        self.timeLabel = timeLabel
        
        let infoLabel = UILabel(frame: .zero).then {
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(self.snp.centerY).offset(4)
                make.left.equalTo(iconView.snp.right).offset(16)
            }
            $0.text = "BUD-LGW, Wizz Air"
            $0.textAlignment = .left
            $0.textColor = UIColor.purpleyGrey.withAlphaComponent(0.74)
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.infoLabel = infoLabel
        
        let segmentDirectLabel = UILabel(frame: .zero).then {
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.bottom.equalTo(timeLabel)
                make.right.equalToSuperview().offset(-16)
            }
            $0.text = "Direct"
            $0.textAlignment = .left
            $0.textColor = .dusk
            $0.font = .systemFont(ofSize: 16, weight: .regular)
        }
        self.segmentDirectLabel = segmentDirectLabel
        
        let durationLabel = UILabel(frame: .zero).then {
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.bottom.equalTo(infoLabel)
                make.right.equalToSuperview().offset(-16)
            }
            $0.text = "2h 25m"
            $0.textAlignment = .left
            $0.textColor = UIColor.purpleyGrey.withAlphaComponent(0.74)
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.durationLabel = durationLabel
    }

    func set(data: FlightLeg) {
        if let imageRawUrl = data.carriers.first?.imageUrl,
            let imageUrl = URL(string: imageRawUrl) {
            self.iconView.af_setImage(withURL: imageUrl)
        }
        if let from = data.departure.dateWithTimeZone?.time24hour,
            let to = data.arrival.dateWithTimeZone?.time24hour {
            self.timeLabel.text = "\(from) - \(to)"
        }
        if let origin = data.origin,
            let destination = data.destination {
            var infoText = "\(origin.code)-\(destination.code), "
            data.carriers.forEach { carrier in
                infoText = "\(infoText) \(carrier.name)"
            }
            self.infoLabel.text = infoText
        }
        let (hours, minutes) = data.duration.toMinutesAndHours
        self.durationLabel.text = hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
        let stopsCount = data.stopIds.count
        self.segmentDirectLabel.text = stopsCount > 0 ? "\(stopsCount) stops" : "Direct"
    }
}
