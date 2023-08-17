import UIKit

final class Appcoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private var option: DeepLinkOption?
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        super.init()
    }
    
    override func start() {
        runFlow()
    }
    
    override func handle(_ option: DeepLinkOption?) {
        self.option = option
        
        childCoordinators.forEach { coordinator in
            coordinator.handle(option)
        }
    }
    private func runFlow() {
        runMainFlow()
    }
    
    private func runMainFlow(with options: DeepLinkOption? = nil) {
        var (coordinator, module) = coordinatorFactory.makeTabbarCoordiator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.resetOption()
            self?.runFlow()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
        coordinator.handle(option)
    }
    
    private func resetOption() {
        option = nil
    }
}


