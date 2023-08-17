import Foundation
import Factory

final class HomeVM: ViewModelType {
    @Injected(\LoginContainer.initializeManager) var initializeManager: Initializable
    @Injected(\.taskManager) var taskManager: TasksManager
    
    var onBackAction: SimpleNavigation?
}
