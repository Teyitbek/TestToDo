import Factory

final class LoginContainer: SharedContainer {
    static var shared = LoginContainer()
    var manager = ContainerManager()
    
    var initializeManager: Factory<Initializable> {
        self { InitializeManager() }.shared
    }
    
    var greetingText: Factory<String> {
        self { "Hello world" }
    }
}
