import Factory
import Foundation

extension SharedContainer {
    var taskManager: Factory<TasksManager> {
        self { TasksManager() }.shared
    }
}
