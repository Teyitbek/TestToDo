import UIKit
import Factory

final class TabbarVC: UITabBarController, TabbarView {
    @Injected(\.taskManager) var taskManager: TasksManager
    
    var onHomeFlowSelect: ((BaseNC) -> Void)?
    var onTaskListFlowSelect: ((BaseNC) -> Void)?
    var onViewDidLoad: ((BaseNC) -> Void)?
    
    lazy var customTabbar = Tabbar()
    
    enum Tab: Int {
        case home
        case taskList
    }
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        setDelegates()
        customTabbar.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        // overlay
        view.addSubview(overlayView)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let controller = viewControllers?.first as? BaseNC {
            didSelectTabbar(tabIndex: Tab(rawValue: selectedIndex) ?? .home)
            onViewDidLoad?(controller)
        }
    }
    
    func didSelectTabbar(tabIndex: Tab) {
        switch tabIndex {
        case .home:
            customTabbar.homeButton.imageView.image = Asset.homeRed.image
            customTabbar.taskButton.imageView.image = Asset.calendarGray.image
            customTabbar.homeButton.titleLabel.textColor = Asset.ee6C46.color
            customTabbar.taskButton.titleLabel.textColor = .gray
            customTabbar.homeButton.backgroundColor = Asset.selectedBtnBack.color
        case .taskList:
            customTabbar.homeButton.imageView.image = Asset.homeGray.image
            customTabbar.taskButton.imageView.image = Asset.calendarRed.image
            customTabbar.homeButton.titleLabel.textColor = .gray
            customTabbar.taskButton.titleLabel.textColor = Asset.ee6C46.color
            customTabbar.taskButton.backgroundColor = Asset.selectedBtnBack.color
        }
    }
}

// MARK: Tabbar Frame
extension TabbarVC {
    func setSubviews() {
        view.addSubview(customTabbar)
        customTabbar.anchor(
            .leading(view.leadingAnchor),
            .trailing(view.trailingAnchor),
            .bottom(view.bottomAnchor),
            .height(135.adaptToScreenSize)
        )
        tabBar.isHidden = true
    }
    
    func setDelegates() {
        delegate = self
        customTabbar.tabbarDelegate = self
    }
}

// MARK: UITabbarControllerDelegate
extension TabbarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? BaseNC else { return }
        guard let tabIndex = Tab(rawValue: selectedIndex) else { return }
        didSelectTabbar(tabIndex: tabIndex)
        switch tabIndex {
        case .home:
            onHomeFlowSelect?(controller)
        case .taskList:
            onTaskListFlowSelect?(controller)
        }
    }
}

extension TabbarVC: TabbarDelegate {
    func didSelect(tag: Int, view: Tabbar) {
        selectedIndex = tag
        tabBarController(self, didSelect: viewControllers?[selectedIndex] as! BaseNC)
    }
}

// MARK: Call Alert
@objc
extension TabbarVC {
    func addButtonTapped() {
        // overlay
        UIView.animate(withDuration: 0.2) {
            self.overlayView.alpha = 1.0
        }
        
        let alert = UIAlertController(title: "Add task", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter name"
        }
        // overlay
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            alert.dismiss(animated: true) {
                UIView.animate(withDuration: 0.2) {
                    self.overlayView.alpha = 0.0
                }
            }
        }
        
        let save = UIAlertAction(title: "Save", style: .cancel, handler: { _ in
            // overlay
            alert.dismiss(animated: true) {
                UIView.animate(withDuration: 0.2) {
                    self.overlayView.alpha = 0.0
                }
            }
            if let text = alert.textFields?.first?.text {
                var savedItems = UserDefaults.standard.getTasks()
                savedItems.append(TaskItem(title: text, isCompleted: false))
                UserDefaults.standard.set(tasks: savedItems)
                self.taskManager.tasks = savedItems  
            }
        })
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true)
    }
}
