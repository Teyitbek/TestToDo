import UIKit

public final class InfoView: UIView {
    lazy var view = makeView()
    lazy var label = makeLabel()
    lazy var imageView = makeImageView()
    
    private let viewWidth = 126.adaptToScreenSize
    private let viewHeight = 40.adaptToScreenSize
    private let imageWidth = 14.adaptToScreenSize
    private let spacing = 12.adaptToScreenSize

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoView: Customizable {
    func setSubviews() {
        addSubview(view)
        view.addSubview(label)
        addSubview(imageView)
    }
    
    func setConstraints() {
        view.anchor(
            .height(viewHeight),
            .width(viewWidth)
        )
        
        label.anchor(
            .leading(view.leadingAnchor, constant: spacing),
            .trailing(view.trailingAnchor, constant: spacing),
            .centerY(view.centerYAnchor)
        )
        
        imageView.anchor(
            .height(viewHeight),
            .width(imageWidth),
            .centerY(view.centerYAnchor),
            .leading(view.trailingAnchor)
        )
    }
}

private extension InfoView {
    func makeView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}


