import UIKit

final class ResultCVCellCV: UIView {
    lazy var backgroundView = makeBackgrondView()
    lazy var stepView = makeStepView()
    lazy var stepTopLineView = makeStepLineView()
    lazy var stepBottomLineView = makeStepLineView()
    
    private let stepViewWidthHeight: CGFloat = 18 * Constants.ScreenSizeConstant
    private let stepLineViewWidth: CGFloat = 5 * Constants.ScreenSizeConstant
    
    var backgroundViewTopConstant: NSLayoutConstraint?
    var backgroundViewBottomConstant: NSLayoutConstraint?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ResultCVCellCV: Customizable {
    func setSubviews() {
        addSubview(backgroundView)
        addSubview(stepView)
        addSubview(stepTopLineView)
        addSubview(stepBottomLineView)
    }
    
    func setConstraints() {
        
        backgroundViewTopConstant = backgroundView.topAnchor.constraint(equalTo: topAnchor)
        backgroundViewTopConstant?.isActive = true
        
        backgroundViewBottomConstant = backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        backgroundViewBottomConstant?.isActive = true
        
        backgroundView.anchor(
            .leading(leadingAnchor),
            .trailing(trailingAnchor)
        )
        
        stepView.anchor(
            .centerY(centerYAnchor),
            .centerX(centerXAnchor),
            .width(stepViewWidthHeight),
            .height(stepViewWidthHeight)
        )
        
        stepTopLineView.anchor(
            .top(topAnchor),
            .bottom(stepView.topAnchor, constant: -1),
            .width(stepLineViewWidth),
            .centerX(centerXAnchor)
        )
        
        stepBottomLineView.anchor(
            .top(stepView.bottomAnchor, constant: -1),
            .bottom(bottomAnchor),
            .width(stepLineViewWidth),
            .centerX(centerXAnchor)
        )
    }
}

private extension ResultCVCellCV {
    func makeBackgrondView() -> UIView {
        let view = UIView()
        view.backgroundColor = Asset.white.color.withAlphaComponent(0.3)
        view.clipsToBounds = true
        return view
    }
    
    func makeStepView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.cornerRadius = stepViewWidthHeight / 2
        view.borderWidth = 3 * Constants.ScreenSizeConstant
        view.borderColor = Asset.white.color
        return view
    }
    
    func makeStepLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = Asset.white.color.withAlphaComponent(0.6)
        return view
    }
}
