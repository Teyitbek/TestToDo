import Foundation
import UIKit

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
    
    func toWeekday() -> String {
        switch self {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return ""
        }
    }
    
    var adaptToScreenSize: CGFloat {
        return CGFloat(self) * Constants.ScreenSizeConstant
    }
}
