import Foundation

typealias SimpleNavigation = (() -> Void)

protocol ViewModelType {
    var initializeManager: Initializable { get set }
}
