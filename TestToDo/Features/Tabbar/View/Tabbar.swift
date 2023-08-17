import UIKit

protocol TabbarDelegate: AnyObject {
    func didSelect(tag: Int, view: Tabbar)
}

class Tabbar: UIView {
    lazy var contentView = makeContentView()
    lazy var stackView = makeStackView()
    lazy var homeButton = makeButton()
    lazy var taskButton = makeButton()
    lazy var addButton = makeAddButton(image: Asset.addTask.image)
    
    private let itemCornerRadius: CGFloat = 15
    private let spacing = 15.adaptToScreenSize
    private let spacingInside = 10.adaptToScreenSize
    private let itemsHeight = 72.adaptToScreenSize
    private let addButtonHeight = 48.adaptToScreenSize
    private let itemsWidth = 50.adaptToScreenSize
    private let addButtonWidth = 70.adaptToScreenSize
    
    weak var tabbarDelegate: TabbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setSubviews() {
        addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(homeButton, taskButton)
        contentView.addSubview(addButton)
    }
    
    func setConstraints() {
        contentView.anchor(
            .top(topAnchor, constant: spacing),
            .leading(leadingAnchor, constant: spacing),
            .trailing(trailingAnchor, constant: spacing),
            .bottom(bottomAnchor, constant: spacing * 2)
        )
        
        stackView.anchor(
            .top(contentView.topAnchor, constant: spacingInside),
            .leading(contentView.leadingAnchor, constant: spacingInside),
            .trailing(contentView.trailingAnchor, constant: spacingInside),
            .bottom(contentView.bottomAnchor, constant: spacingInside)
        )
        
        homeButton.anchor(
            .height(itemsHeight),
            .width(DeviceScreenSize.current == .small ? 120.adaptToScreenSize : 140.adaptToScreenSize)
        )
                
        taskButton.anchor(
            .height(itemsHeight),
            .width(DeviceScreenSize.current == .small ? 120.adaptToScreenSize : 140.adaptToScreenSize)
        )
        
        addButton.anchor(
            .width(addButtonWidth),
            .top(contentView.topAnchor),
            .bottom(contentView.bottomAnchor),
            .centerX(centerXAnchor)
        )
    }
    
    func setProperties() {
        backgroundColor = .clear
        homeButton.tag = 0
        taskButton.tag = 1
        homeButton.titleLabel.text = "Home"
        taskButton.titleLabel.text = "Task List"
    }
}

// MARK: - make Methods
extension Tabbar {
    func makeContentView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = itemCornerRadius * 1.4
        return view
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.distribution = .equalCentering
        stackView.layer.cornerRadius = itemCornerRadius
        stackView.clipsToBounds = true
        stackView.spacing = addButtonWidth
        return stackView
    }
    
    func makeButton() -> CustomTabbarButton {
        let button = CustomTabbarButton()
        button.backgroundColor = Asset.defaultBtnBack.color
        button.addTarget(self, action: #selector(onButtonAction(_:)), for: .touchUpInside)
        button.layer.cornerRadius = itemCornerRadius
        return button
    }
    
    func makeAddButton(image: UIImage) -> AddTaskButton {
        let button = AddTaskButton()
        button.imageView.image = image
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        return button
    }
}

@objc
extension Tabbar {
    func onButtonAction(_ button: CustomTabbarButton) {
        tabbarDelegate?.didSelect(tag: button.tag, view: self)
    }
}

