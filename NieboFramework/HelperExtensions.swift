import Foundation

public extension String {
    var dateWithTimeZone: Date? {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        }
        return formatter.date(from: self)
    }
    
    var dateNoTimeZone: Date? {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        return formatter.date(from: self)
    }
}

public extension Date {
    var time24hour: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "HH:mm"
        }
        return formatter.string(from: self)
    }
    
    var monthDayAndDayOfTheWeek: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "MMM dd',' E"
        }
        return formatter.string(from: self)
    }
}

public extension Int {
    var toMinutesAndHours: (Int, Int) {
        return (self / 60, self % 60)
    }
}
