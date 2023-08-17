import UIKit

class BaseNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
    
    func popToRoot() {
        guard let root = viewControllers.first else { return }
        setViewControllers([root], animated: false)
    }
}
