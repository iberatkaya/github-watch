import Foundation
import SwiftyJSON


/// Taken from: https://stackoverflow.com/a/36805702.
/// Author: https://stackoverflow.com/users/23649/jtbandes
public extension JSON {
    var date: Date? {
        if let str = string {
            return JSON.jsonDateFormatter.date(from: str)
        }
        return nil
    }

    private static let jsonDateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        fmt.timeZone = TimeZone(secondsFromGMT: 0)
        return fmt
    }()
}
