import UIKit

final class ResultCVCell: CollectionViewCell<ResultCVCellCV> {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        mainContentView.backgroundColor = .clear
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainContentView.stepTopLineView.isHidden = false
        mainContentView.stepBottomLineView.isHidden = false
    }
    
    func setup(isCompleted: Bool, isFirst: Bool, isLast: Bool) {
        mainContentView.stepView.backgroundColor = isCompleted ? .green : .lightGray
        
        if isFirst {
            mainContentView.backgroundViewTopConstant?.constant = frame.height / 4
            mainContentView.stepTopLineView.isHidden = true
        } else {
            mainContentView.backgroundView.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 0)
            mainContentView.backgroundViewTopConstant?.constant = 0
            mainContentView.stepTopLineView.isHidden = false
        }
        
        if isLast {
            mainContentView.backgroundViewBottomConstant?.constant = -(frame.height / 4)
            mainContentView.stepBottomLineView.isHidden = true
        } else {
            mainContentView.backgroundView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 0)
            mainContentView.backgroundViewBottomConstant?.constant = 0
            mainContentView.stepBottomLineView.isHidden = false
        }
    }
}
