import Combine
import Foundation
import UIKit

final class TasksManager: NSObject {
    var tasksUpdatedSubject = PassthroughSubject<[TaskItem], Never>()
    var tasks: [TaskItem] = [] {
        didSet {
            tasksUpdatedSubject.send(tasks)
        }
    }
    
    override init() {
        super.init()
        tasks = UserDefaults.standard.getTasks()
    }
    
    func getFilteredTasks() -> [TaskItem] {
        let sorted = tasks.sorted { !$0.isCompleted && $1.isCompleted }
        return sorted
    }
    
    private var count = 0
    private var completed = 0
    private var percent: CGFloat = 0
    
    func getCompletedPercentage() -> CGFloat {
        count = 0
        completed = 0

        for i in tasks {
            count += 1
            if i.isCompleted {
                completed += 1
            }
        }
        if count > 0 {
            percent = CGFloat(completed) / CGFloat(count)
        } else {
            percent = 0
        }
        return percent
    }
}
