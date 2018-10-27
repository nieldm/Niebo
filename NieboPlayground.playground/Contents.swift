import UIKit
import PlaygroundSupport
import NieboFramework
import Then

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel().then {
            $0.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
            $0.text = "Playground Support"
            $0.textColor = .black
            view.addSubview($0)
        }
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
