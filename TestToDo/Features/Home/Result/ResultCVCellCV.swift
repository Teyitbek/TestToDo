import UIKit

enum Position {
    case top
    case center
    case bottom
}

final class ResultCVCellCV: UIView {
    lazy var outsideView = makeView(cornerRadius: outsideViewHeight / 2)
    lazy var insideView = makeView(color: .lightGray, cornerRadius: insideViewHeight / 2)
    
    var position: Position = .center
    
    private let outsideViewHeight = 20.adaptToScreenSize
    private let insideViewHeight = 13.adaptToScreenSize
    
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
extension ResultCVCellCV {
}

// MARK: - BaseCV functions
extension ResultCVCellCV: Customizable {
    func setSubviews() {
        addSubview(outsideView)
        outsideView.addSubview(insideView)
    }
    
    func setConstraints() {
        switch position {
        case .top:
            outsideView.anchor(
                .top(topAnchor), // this
                .centerX(centerXAnchor),
                .height(outsideViewHeight),
                .width(outsideViewHeight)
            )
        case .center:
            outsideView.anchor(
                .centerX(centerXAnchor),
                .centerY(centerYAnchor), // this
                .height(outsideViewHeight),
                .width(outsideViewHeight)
            )
        case .bottom:
            outsideView.anchor(
                .centerX(centerXAnchor),
                .height(outsideViewHeight),
                .width(outsideViewHeight),
                .bottom(bottomAnchor) // this 
            )
        }
        
        insideView.anchor(
            .centerX(outsideView.centerXAnchor),
            .centerY(outsideView.centerYAnchor),
            .height(insideViewHeight),
            .width(insideViewHeight)
        )
    }
    
    func setProperties() {
    }
}

// MARK: - Factory functions
private extension ResultCVCellCV {
    func makeView(color: UIColor? = .white, cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
        return view
    }
}
