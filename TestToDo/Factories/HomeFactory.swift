import UIKit

protocol HomeFactoryImpl {
    func makeHomeVC() -> HomeVC
}

final class HomeFactory: HomeFactoryImpl {
    func makeHomeVC() -> HomeVC {
        HomeBuilder().build()
    }
}
