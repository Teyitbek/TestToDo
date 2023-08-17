import UIKit
import Foundation
import Factory

enum DeepLinkOption {
    case test

    static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let url = userActivity.webpageURL,
           let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            print("URL components: \(components)")
        }
        return nil
    }

    static func build(with userInfo: [AnyHashable: Any]) -> DeepLinkOption? {
        guard let notification = PushNotification.map(userInfo) else { return nil }

        switch notification.type {
        case .test:
            return .test
        }
    }
}

