import UIKit

// swiftlint: disable line_length
final class AppCoordinatorFactory: CoordinatorFactory {
    func makeTabbarCoordiator(router: Router) -> (configurator: Coordinator & TabbarCoordinatorResult, toPresent: Presentable?) {
        let controller = TabbarVC()
        let factory = AppCoordinatorFactory()
        let coordinator = TabbarCoordinator(tabbarView: controller, coordinatorFactory: factory, router: router)
        let firstController = makeNC()
        let secondController = makeNC()
        controller.viewControllers = [firstController, secondController]
        return (coordinator, controller)
    }
        
    func makeHomeCoordinator(navController: BaseNC?, mainRouter: Router) -> Coordinator & HomeCoordinatorResult {
        let factory = HomeFactory()
        return HomeCoordinator(router: router(navController), factory: factory, mainFactory: mainRouter)
    }
    
    func makeTaskListCoordinator(navController: BaseNC?, mainRouter: Router) -> Coordinator & TaskListCoordinatorResult {
        let factory = TaskListFactory()
        return TaskListCoordinator(router: router(navController), factory: factory, mainRouter: mainRouter)
    }
}

extension AppCoordinatorFactory {
    private func router(_ navController: BaseNC?) -> Router {
        return AppRouter(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: BaseNC?) -> BaseNC {
        if let navController = navController {
            return navController
        } else { return BaseNC() }
    }
    
    private func makeNC() -> BaseNC {
        let controller = BaseNC()
        controller.navigationBar.isHidden = true
        return controller
    }
}
