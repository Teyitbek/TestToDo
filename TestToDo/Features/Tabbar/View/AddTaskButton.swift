import UIKit

final class AddTaskButton: UIControl {
    lazy var imageView = makeImageView()
    
    private let imageViewHeightWidth: CGFloat = 48.adaptToScreenSize
    
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
        imageView.layer.shadowColor = Asset.ee6C46.color.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.shadowRadius = CGFloat(8)
    }
}
// MARK: - Content view setupable
extension AddTaskButton: Customizable {
    func setSubviews() {
        addSubview(imageView)
    }
    
    func setConstraints() {
        imageView.anchor(
            .height(imageViewHeightWidth),
            .width(imageViewHeightWidth),
            .centerY(centerYAnchor),
            .centerX(centerXAnchor)
        )
    }
    
    func setProperties() {
        backgroundColor = .lightGray
    }
    
    override public var isHighlighted: Bool {
        didSet {
            var highlightedAlpha: CGFloat = 1.0
            highlightedAlpha = isHighlighted ? 0.5 : 1.0
            imageView.alpha = highlightedAlpha
        }
    }
}

// MARK: - Factory functions
extension AddTaskButton {
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
