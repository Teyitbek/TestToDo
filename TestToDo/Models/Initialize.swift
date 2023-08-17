import Foundation
//import Defaults

struct Initialize: Codable {
    let currentLocale: String
    let labelList: [String: String]
    
    init() {
        currentLocale = ""
        labelList = [:]
    }
}
