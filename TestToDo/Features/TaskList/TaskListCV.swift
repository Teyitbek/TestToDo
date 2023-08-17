import UIKit

public final class TaskListCV: UIView {
    lazy var leftEditButton = makeButton()
    lazy var topTitle = makeTitle()
    lazy var topSeparatorView = makeView()
    lazy var tableView = makeTableView()
    
    private let topSpacing = 15.adaptToScreenSize
    private let topSeparatorHeight = 1.adaptToScreenSize
    private let topTitleWidth = 150.adaptToScreenSize
    private let topTitleHeight = 32.adaptToScreenSize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setProperties()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup subviews and constraints
extension TaskListCV: Customizable {
    func setSubviews() {
        addSubview(leftEditButton)
        addSubview(topTitle)
        addSubview(topSeparatorView)
        addSubview(tableView)
    }
    
    func setConstraints() {
        leftEditButton.anchor(
            .top(safeAreaLayoutGuide.topAnchor, constant: topSpacing),
            .leading(leadingAnchor),
            .width(topTitleHeight * 2),
            .height(topTitleHeight)
        )
        
        topTitle.anchor(
            .top(safeAreaLayoutGuide.topAnchor, constant: topSpacing),
            .centerX(centerXAnchor),
            .widthGreaterThanConstant(topTitleWidth),
            .height(topTitleHeight)
        )
        
        topSeparatorView.anchor(
            .top(topTitle.bottomAnchor),
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .height(topSeparatorHeight)
        )
        
        tableView.anchor(
            .top(topSeparatorView.bottomAnchor),
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .bottom(bottomAnchor)
        )
    }
    
    func setProperties() {
        backgroundColor = Asset.taskViewBg.color
    }
}

private extension TaskListCV {
    
    func makeButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(Asset.leftEdit.color, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }
    
    func makeTitle() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }
    
    func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    
    func makeTableView() -> TableView {
        let tableView = TableView(style: .plain,
                                  cells: [
                                    TasksTVCell.self
                                  ])
        tableView.separatorStyle = .singleLine
        tableView.register(TaskListFooterView.self, forHeaderFooterViewReuseIdentifier: TaskListFooterView.reuseIdentifier)
        return tableView
    }
}
