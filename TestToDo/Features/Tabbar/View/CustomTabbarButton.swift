import UIKit

enum CustomTabbarButtonState {
    case selected
    case unselected
}

// MARK: - Main
final class CustomTabbarButton: UIControl {
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    
    private let imageViewHeightWidth: CGFloat = 24.adaptToScreenSize
    private let topSpacing: CGFloat = 10.adaptToScreenSize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
        setProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Content view setupable
extension CustomTabbarButton: Customizable {
    func setSubviews() {
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    func setConstraints() {
        imageView.anchor(
            .height(imageViewHeightWidth),
            .width(imageViewHeightWidth),
            .centerX(centerXAnchor),
            .top(topAnchor, constant: topSpacing)
        )
        
        titleLabel.anchor(
            .centerX(centerXAnchor),
            .top(imageView.bottomAnchor, constant: topSpacing),
            .height(imageViewHeightWidth),
            .leading(leadingAnchor),
            .trailing(trailingAnchor)
        )
    }
    
    func setProperties() {
        backgroundColor = .lightGray
    }
    
    override public var isHighlighted: Bool {
        didSet {
            var highlightedAlpha: CGFloat = 1.0
            highlightedAlpha = isHighlighted ? 0.5 : 1.0
            titleLabel.textColor = titleLabel.textColor.withAlphaComponent(highlightedAlpha)
            imageView.alpha = highlightedAlpha
        }
    }
}

// MARK: - Factory functions
extension CustomTabbarButton {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
}
