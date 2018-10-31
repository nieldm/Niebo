import UIKit
import NieboFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = ResultsViewController()
        let nav = UINavigationController(rootViewController: vc).then {
            $0.setNavigationBarHidden(true, animated: false)
            $0.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        }
        let tab = UITabBarController().then {
            $0.setViewControllers([nav], animated: false)
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}


}

