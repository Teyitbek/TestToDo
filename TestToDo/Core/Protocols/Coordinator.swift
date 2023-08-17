protocol Coordinator: AnyObject {
    func start()
    func handle(_ option: DeepLinkOption?)
}
