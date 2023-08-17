protocol HomeCoordinatorResult {
    var finishFlow: (() -> Void)? { get set }
    var onRecoveringFlow: (() -> Void)? { get set }
}
