// Hour.swift

import Foundation

// MARK: - Hour
struct Hour: Codable {
    let open: [Open]
    let hoursType: String
    let isOpenNow: Bool
    
    var hourOpenTransformed: [OpenHourData] {
        var hourData = [OpenHourData]()
        return open.map { $0.transformed }.reduce(hourData) { partialResult, value in
            if var x = partialResult.first(where: { $0.day == value.day }) {
                x.hours = x.hours + "\n" + value.hours
            } else {
                hourData.append(value)
            }
            return hourData
        }
    }
}
