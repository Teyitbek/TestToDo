import UIKit

final class TasksTVCellCV: UIView {
    lazy var isCompletedButton = makeButton(image: Asset.emptyRound.image)
    lazy var label = makeLabel()
    
    private let cellItemsHeight = 35.adaptToScreenSize
    private let spacing = 15.adaptToScreenSize
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper functions
extension TasksTVCellCV {
}

// MARK: - BaseCV functions
extension TasksTVCellCV: Customizable {
    func setSubviews() {
        addSubview(isCompletedButton)
        addSubview(label)
    }
    
    func setConstraints() {
        isCompletedButton.anchor(
            .leading(leadingAnchor, constant: spacing),
            .centerY(centerYAnchor),
            .height(cellItemsHeight),
            .width(cellItemsHeight)
        )
        
        label.anchor(
            .leading(isCompletedButton.trailingAnchor, constant: spacing),
            .centerY(isCompletedButton.centerYAnchor),
            .height(cellItemsHeight),
            .trailing(trailingAnchor, constant: spacing)
        )
    }
    
    func setProperties() {
    }
}

// MARK: - Factory functions
private extension TasksTVCellCV {
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }
    
    func makeButton( image: UIImage) -> UIButton {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        return button
    }
}
