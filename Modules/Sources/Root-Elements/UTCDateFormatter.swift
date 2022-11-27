import Foundation

public extension Calendar {
    static var current: Self {
        var calendar: Self = .init(identifier: .gregorian)
        calendar.locale = .current
        calendar.timeZone = .current
        return calendar
    }
}

public protocol UTCDateFormatterProtocol {
    var isToday: (_ date: Date) -> Bool { get }
    var isDateInThisWeek: (_ current: Date, _ date: Date) -> Bool { get }
    var currentDate: () -> Date { get }
    func toLocal(_ date: String) -> String?
}

public struct UTCDateFormatter: UTCDateFormatterProtocol {
    public let isToday: (_ date: Date) -> Bool
    public let isDateInThisWeek: (_ current: Date, _ date: Date) -> Bool
    public let currentDate: () -> Date

    public init(
        isToday: @escaping (_ date: Date) -> Bool = { date in
            let calendar: Calendar = .current
            return calendar.isDateInToday(date)
        },
        isDateInThisWeek: @escaping (_ current: Date, _ date: Date) -> Bool = { current, date in
            let calendar: Calendar = .current
            return calendar.isDate(current, equalTo: date,toGranularity: .weekOfYear)
        },
        currentDate: @escaping () -> Date = {
            Date()
        }
    ) {
        self.isToday = isToday
        self.isDateInThisWeek = isDateInThisWeek
        self.currentDate = currentDate
    }

    public func toLocal(_ date: String) -> String? {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: date) else { return nil }

        let calendar: Calendar = .current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let time = String(format:"%02d:%02d", hours, minutes)

        guard isToday(date) == false else { return "Hoje, \(time)"}

        let day = String(format:"%02d", calendar.component(.day, from: date))
        let month = calendar.component(.month, from: date)
        let fallback = "\(day).\(month) \(time)"
        let today = currentDate()

        guard isDateInThisWeek(today, date) else { return fallback }

        if let weekday = Weekday(rawValue: calendar.component(.weekday, from: date)) {
            return "\(weekday.description), \(time)"
        } else {
            return fallback
        }
    }
}

public extension UTCDateFormatter {
    enum Weekday: Int, CaseIterable {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

        var description: String {
            switch self {
                case .sunday: return "Dom"
                case .monday: return "Seg"
                case .tuesday: return "Ter"
                case .wednesday: return "Qua"
                case .thursday: return "Qui"
                case .friday: return "Sex"
                case .saturday: return "Sáb"
            }
        }
    }
}
