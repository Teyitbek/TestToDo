import UIKit

final class ResultCVCell: CollectionViewCell<ResultCVCellCV> {
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(isCompleted: Bool) {
        if isCompleted {
            mainContentView.insideView.backgroundColor = .green
        } else {
            mainContentView.insideView.backgroundColor = .lightGray
        }
    }
    
}
