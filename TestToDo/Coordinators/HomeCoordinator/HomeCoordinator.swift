final class HomeCoordinator: BaseCoordinator, HomeCoordinatorResult {
    var finishFlow: (() -> Void)?
    var onRecoveringFlow: (() -> Void)?
    
    private let router: Router
    private let mainRouter: Router
    private let factory: HomeFactory
    
    init(router: Router, factory: HomeFactory, mainFactory: Router) {
        self.router = router
        self.factory = factory
        self.mainRouter = mainFactory
    }
    
    override func start() {
        showHomeVC()
    }
    
    private func showHomeVC() {
        let module = factory.makeHomeVC()
        router.setRootModule(module, hideBar: true)
    }
}
