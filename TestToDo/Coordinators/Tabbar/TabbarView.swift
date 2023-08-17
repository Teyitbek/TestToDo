import UIKit

protocol TabbarView: AnyObject {
    var onHomeFlowSelect: ((BaseNC) -> Void)? { get set }
    var onTaskListFlowSelect: ((BaseNC) -> Void)? { get set }
}
