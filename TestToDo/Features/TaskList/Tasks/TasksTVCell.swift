import UIKit
import Factory

final class TasksTVCell: TableViewCell<TasksTVCellCV> {
//    @Injected(\.taskManager) var taskManager: TasksManager
    
    var isCompletedAction: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainContentView.isCompletedButton.addTarget(self, action: #selector(isCompletedActionTapped), for: .touchUpInside)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: TaskItem) {
        mainContentView.label.text = model.title
        mainContentView.isCompletedButton.setImage(model.isCompleted ? Asset.radio.image : Asset.emptyRound.image, for: .normal)
    }
}

@objc
extension TasksTVCell {
    func isCompletedActionTapped() {
        isCompletedAction?()
    }
}
