import UIKit

public class RefreshControl: UIRefreshControl {
    public init(tintColor: UIColor) {
        super.init()
        self.tintColor = tintColor
        self.layer.zPosition = -1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
