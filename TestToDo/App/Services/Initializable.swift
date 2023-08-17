import Combine
import Foundation

protocol Initializable {
    var strings: PassthroughSubject<Initialize, Never> { get set }
}

final class InitializeManager: Initializable {
    var strings = PassthroughSubject<Initialize, Never>()
}

extension String {
    func localized(by config: Initialize) -> String {
        return config.labelList[self] ?? self
    }
}
