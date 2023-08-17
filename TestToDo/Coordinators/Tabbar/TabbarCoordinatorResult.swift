import UIKit

protocol TabbarCoordinatorResult {
    var finishFlow: (() -> Void)? { get set }
}
