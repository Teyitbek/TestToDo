import UIKit

enum Constants {
    enum UI {
        static let viewsTop: CGFloat = 16.adaptToScreenSize
        static let viewsLeadingTrailing: CGFloat = 16.adaptToScreenSize
        static let idButtonHeight: CGFloat = 56.adaptToScreenSize
        static let bottom: CGFloat = 20.adaptToScreenSize
    }
    
    enum UserDefaultsKeys {
        static let configurations = "Configurations"
        static let sawRecoveringAnimation = "Recovering"
        static let sawOrganizingAnimation = "Organizing"
        static let sawConnectionAnimation = "Connection"
        static let sawAlertingAnimation = "Alerting"
        static let sawSharingAnimation = "Sharing"
    }
    
    static var ScreenSizeConstant: CGFloat {
        switch DeviceScreenSize.current {
        case .large:
            return 1.0
        case .normal:
            return 0.9
        case .small:
            return 0.85
        }
    }
}
