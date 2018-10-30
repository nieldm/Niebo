import UIKit
import AlamofireImage

public class SegmentView: UIView {
    
    private var iconView: UIImageView!
    
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
    }

    func set(data: Segment) {
        if let imageRawUrl = data.carrier?.imageUrl,
            let imageUrl = URL(string: imageRawUrl) {
            self.iconView.af_setImage(withURL: imageUrl)
        }
    }
}
