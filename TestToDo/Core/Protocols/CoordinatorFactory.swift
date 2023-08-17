protocol CoordinatorFactory {
    func makeHomeCoordinator(navController: BaseNC?, mainRouter: Router) -> Coordinator & HomeCoordinatorResult
    func makeTaskListCoordinator(navController: BaseNC?, mainRouter: Router) -> Coordinator & TaskListCoordinatorResult
    
    func makeTabbarCoordiator(router: Router) -> (configurator: Coordinator & TabbarCoordinatorResult, toPresent: Presentable?)
}
