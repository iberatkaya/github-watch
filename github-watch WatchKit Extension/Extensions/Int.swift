import Foundation

/// Taken from https://stackoverflow.com/a/45508260
/// Authors: https://stackoverflow.com/users/2177402/islam-q and https://stackoverflow.com/users/3797965/mitja13
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10) / 10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10) / 10)K"
        }
        else {
            return "\(self)"
        }
    }
}
