import UIKit
import Factory

final class TaskListVC: BaseVC<TaskListCV, TaskListVM> {
    lazy var tabbar = TabbarVC()
    private var leftEditButtonTitle = "Edit"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.isEditing = false
        viewModel.taskManager.tasksUpdatedSubject.sink { [weak self] tasks in
            self?.updateItems()
        }.store(in: &bag)
        
        view.backgroundColor = Asset.backgroundTaskVC.color
    }

    override func setLocalization() {
        contentView.topTitle.text = "Task List"
        contentView.leftEditButton.setTitle(leftEditButtonTitle, for: .normal)
    }
    
    override func setTargets() {
        contentView.leftEditButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
    }
}

// MARK: - Actions
@objc
extension TaskListVC {
    func editButtonTapped(_ button: UIButton) {
        contentView.tableView.isEditing = !contentView.tableView.isEditing
        button.setTitle(contentView.tableView.isEditing ? "Done" : "Edit", for: .normal)
    }
    
    func onBackAction() {
        viewModel.onBackAction?()
    }
}

// MARK: TableView
extension TaskListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskManager.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TasksTVCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(model: viewModel.taskManager.tasks[indexPath.row])
        cell.isCompletedAction = { [weak self] in
            self?.isCompletedAction(at: indexPath)
        }
        cell.overrideUserInterfaceStyle = .light
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.adaptToScreenSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.taskManager.tasks.remove(at: indexPath.row)
            UserDefaults.standard.set(tasks: viewModel.taskManager.tasks)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedIndexPath = viewModel.taskManager.tasks.remove(at: sourceIndexPath.row)
        viewModel.taskManager.tasks.insert(movedIndexPath, at: destinationIndexPath.row)
        UserDefaults.standard.set(tasks: viewModel.taskManager.tasks)
        contentView.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteRowAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 130.adaptToScreenSize
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskListFooterView.reuseIdentifier) as! TaskListFooterView
        return footerView
    }
}

// MARK: Methods for TableView
@objc
extension TaskListVC {
    func updateItems() {
        contentView.tableView.reloadData()
    }
    
    func deleteRowAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            self?.viewModel.taskManager.tasks.remove(at: indexPath.row)
            UserDefaults.standard.set(tasks: (self?.viewModel.taskManager.tasks)!)
            completion(true)
        }
        action.backgroundColor = .red
        return action
    }
    
    func isCompletedAction(at indexPath: IndexPath) {
        viewModel.taskManager.tasks[indexPath.row].isCompleted = !viewModel.taskManager.tasks[indexPath.row].isCompleted
        UserDefaults.standard.set(tasks: viewModel.taskManager.tasks)
        contentView.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


