// Open.swift

import Foundation

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool
    let start: String
    let end: String
    let day: Int
    
    var transformed: OpenHourData {
        var start = self.start
        start.insert(":", at: start.index(start.startIndex, offsetBy: 2))
        var end = self.start
        end.insert(":", at: end.index(end.startIndex, offsetBy: 2))
        return OpenHourData(day: Calendar.current.weekdaySymbols[day], hours: "\(start) - \(end)")
    }
}

struct OpenHourData: Codable {
    let day: String
    var hours: String
}
