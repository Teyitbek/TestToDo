import Foundation
import UIKit

final class HomeBuilder: ModuleBuilder {
    var contentView: HomeCV
    var viewModel: HomeVM
    var viewController: HomeVC
    
    required init() {
        contentView = HomeCV()
        viewModel = HomeVM()
        viewController = HomeVC(contentView: contentView, viewModel: viewModel)
    }
    
    func build() -> HomeVC {
        return viewController
    }
}
