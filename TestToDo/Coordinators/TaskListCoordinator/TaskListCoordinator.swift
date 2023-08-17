final class TaskListCoordinator: BaseCoordinator, TaskListCoordinatorResult {
    var finishFlow: (() -> Void)?
    private let router: Router
    private let factory: TaskListFactory
    private let mainRouter: Router
    
    init(router: Router, factory: TaskListFactory, mainRouter: Router) {
        self.router = router
        self.factory = factory
        self.mainRouter = mainRouter
    }
    
    override func start() {
        showTaskListVC()
    }
    
    private func showTaskListVC() {
        let module = factory.makeTaskListVC()
        router.setRootModule(module)
    }
}
