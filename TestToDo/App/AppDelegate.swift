import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var rootController = UINavigationController()
    lazy var appCoordinator = makeAppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        appCoordinator.start()
        
        return true
    }
}

private extension AppDelegate {
    private func makeAppCoordinator() -> Coordinator {
        let router = AppRouter(rootController: rootController)
        let appCoordinatorFactory = AppCoordinatorFactory()
        return Appcoordinator(router: router, coordinatorFactory: appCoordinatorFactory)
    }
}

