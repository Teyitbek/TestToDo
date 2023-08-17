import Foundation
import UIKit

final class TaskListBuilder: ModuleBuilder {
    var contentView: TaskListCV
    var viewModel: TaskListVM
    var viewController: TaskListVC
    
    required init() {
        contentView = TaskListCV()
        viewModel = TaskListVM()
        viewController = TaskListVC(contentView: contentView, viewModel: viewModel)
    }
    
    func build() -> TaskListVC {
        return viewController
    }
}
