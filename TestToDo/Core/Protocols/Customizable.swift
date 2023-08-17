import Foundation
import UIKit

protocol Customizable where Self: UIView {
    func setSubviews()
    func setConstraints()
    func setProperties()
}

extension Customizable {
    func setProperties() {
        backgroundColor = .white
    }
}
