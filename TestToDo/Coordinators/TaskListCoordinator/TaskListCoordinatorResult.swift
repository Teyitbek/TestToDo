protocol TaskListCoordinatorResult {
    var finishFlow: (() -> Void)? { get set }
}
