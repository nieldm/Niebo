import UIKit
import PlaygroundSupport
import NieboFramework
import Then

let vc = ResultsViewController(
    viewModel: ResultsViewModel(
        model: PricingModel(mocked: true)
    )
)
let nav = UINavigationController(rootViewController: vc)
nav.setNavigationBarHidden(true, animated: false)
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = nav
