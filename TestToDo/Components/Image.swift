import UIKit

public final class Image: UIControl {
    public lazy var imageView: UIImageView = makeImageView()
    var imageViewConstraints: AnchoredConstraints?
    var imageViewSize: CGFloat = 24 * Constants.ScreenSizeConstant

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    private func setSubviews() {
        addSubview(imageView)
    }

    private func setConstraints() {
        imageViewConstraints = imageView.anchor(
            .centerX(centerXAnchor),
            .centerY(centerYAnchor),
            .width(imageViewSize),
            .height(imageViewSize)
        )
    }
    
    override public var isHighlighted: Bool {
        didSet {
            var highlightedAlpha: CGFloat = 1.0
            highlightedAlpha = isHighlighted ? 0.5 : 1.0
            imageView.alpha = highlightedAlpha
            transform = isHighlighted ? CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95) : CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }
    }
}

private extension Image {
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}


