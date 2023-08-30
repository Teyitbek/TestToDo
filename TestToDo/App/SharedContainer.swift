import Factory
import Foundation

extension SharedContainer {
    var taskManager: Factory<TasksManager> {
        self { TasksManager() }.shared
    }
    
    var locationManager: Factory<LocationManager> {
        self { LocationManager() }.shared
    }
}
