import UIKit

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorResult {
    var finishFlow: (() -> Void)?
    var taskModel = [TaskItem]()
    
    private let tabbarVC: TabbarVC
    private let coordinatorFactory: CoordinatorFactory
    private let mainRouter: Router
    private var mainCoordinator: (Coordinator & HomeCoordinatorResult)?
    
    init(tabbarView: TabbarVC, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.tabbarVC = tabbarView
        self.coordinatorFactory = coordinatorFactory
        self.mainRouter = router
    }
    
    override func start() {
        setCallbacksToTabs()
    }
    
    override func handle(_ option: DeepLinkOption?) {
    }
    
    private func setCallbacksToTabs() {
        tabbarVC.onViewDidLoad = runHomeFlow()
        tabbarVC.onHomeFlowSelect = runHomeFlow()
        tabbarVC.onTaskListFlowSelect = runTaskListFlow()
    }
    
    private func runHomeFlow() -> ((BaseNC) -> Void) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty {
                var homeCoordinator = self.coordinatorFactory.makeHomeCoordinator(navController: navController, mainRouter: mainRouter)
                homeCoordinator.finishFlow = { [weak self] in
                    self?.finishFlow?()
                }
                self.addDependency(homeCoordinator)
                homeCoordinator.start()
            }
        }
    }
    
    private func runTaskListFlow() -> ((BaseNC) -> Void) {
        return { [unowned self] navController in
            if navController.viewControllers.isEmpty {
                var taskListCoordinator = self.coordinatorFactory.makeTaskListCoordinator(navController: navController, mainRouter: mainRouter)
                taskListCoordinator.finishFlow = { [weak self] in
                    self?.finishFlow?()
                }
                self.addDependency(taskListCoordinator)
                taskListCoordinator.start()
            }
        }
    }
}
