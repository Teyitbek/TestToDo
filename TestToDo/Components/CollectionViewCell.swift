import UIKit

class CollectionViewCell<ContentView: Customizable>: UICollectionViewCell {
    public let mainContentView = ContentView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(mainContentView)
        self.mainContentView.fillSuperview()
        self.backgroundColor = .clear
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
