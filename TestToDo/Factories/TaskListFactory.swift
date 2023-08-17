import UIKit

protocol TaskListFactoryImpl {
    func makeTaskListVC() -> TaskListVC
}

final class TaskListFactory: TaskListFactoryImpl {
    func makeTaskListVC() -> TaskListVC {
        return TaskListBuilder().build()
    }
}
