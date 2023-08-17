import UIKit

public class EmptyPlaceholderView: UIView {
    public enum State {
        case hiden
        case visible
    }
    
    public lazy var emptyBoxImageView = makeEmptyBoxImageView()
    public lazy var titleLabel = makeTitleLabel()
    public lazy var actionButton = makeActionButton()
    
    private let emptyBoxImageViewHeight: CGFloat = 168 * Constants.ScreenSizeConstant
    private let emptyBoxImageViewWidth: CGFloat = 202 * Constants.ScreenSizeConstant
    private let emptyBoxImageViewCenterY: CGFloat = 80 * Constants.ScreenSizeConstant
    private let titleLabelTop: CGFloat = 12 * Constants.ScreenSizeConstant
    private let actionButtonTop: CGFloat = 8 * Constants.ScreenSizeConstant
    private let titleLabelLeadingTrailing: CGFloat = 48 * Constants.ScreenSizeConstant
    
    public init() {
        super.init(frame: .zero)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyPlaceholderView: Customizable {
    public func setSubviews() {
        addSubview(emptyBoxImageView)
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    public func setConstraints() {
        emptyBoxImageView.anchor(
            .centerY(centerYAnchor, constant: -emptyBoxImageViewCenterY),
            .centerX(centerXAnchor),
            .height(emptyBoxImageViewHeight),
            .width(emptyBoxImageViewWidth)
        )
        
        titleLabel.anchor(
            .top(emptyBoxImageView.bottomAnchor, constant: titleLabelTop),
            .centerX(centerXAnchor),
            .widthTo(widthAnchor, 0.8)
        )
        
        actionButton.anchor(
            .top(titleLabel.bottomAnchor, constant: actionButtonTop),
            .centerX(centerXAnchor)
        )
    }
}

extension EmptyPlaceholderView {
    func makeEmptyBoxImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
    func makeActionButton() -> UIButton {
         let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.black, for: .normal)
        return button
    }
}
