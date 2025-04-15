//
//  CalendarViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

@Observable
class CalendarViewModel {
    var currentMonth: Date
    var selectedDate: Date
    var holidayDates: Set<Date> = []
    var calendar: Calendar
    
    init(currentMonth: Date = Date(), selectedDate: Date = Date(), calendar: Calendar = Calendar.current) {
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
        self.calendar = calendar
    }
    
    /// 현재 월 변경
    /// - Parameter value: 선택한 값
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func daysForCurrentGrid() -> [CalendarDay] {
        let calendar = Calendar.current
        let firstDay = firstDayOfMonth()
        let firstWeekDay = calendar.component(.weekday, from: firstDay)
        let daysInMonth = numberOfDays(in: currentMonth)
        
        var days: [CalendarDay] = []

        
        let leadingDays = max((firstWeekDay - calendar.firstWeekday + 7) % 7, 0)
        
        if leadingDays > 0, let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            let daysInPreviousMonth = numberOfDays(in: previousMonth)
            for i in 0..<leadingDays {
                let day = daysInPreviousMonth - leadingDays + i + 1
                if let date = calendar.date(bySetting: .day, value: day, of: previousMonth) {
                    let isHoliday = calendar.isHoliday(date, in: holidayDates)
                    days.append(CalendarDay(day: day, date: date, isCurrentMonth: false, isHoliday: isHoliday))
                }
            }
        }

        for day in 1...daysInMonth {
            let validDay = min(day, daysInMonth)
            if let date = calendar.date(bySetting: .day, value: validDay, of: currentMonth) {
                let isHoliday = calendar.isHoliday(date, in: holidayDates)
                days.append(CalendarDay(day: validDay, date: date, isCurrentMonth: true, isHoliday: isHoliday))
            }
        }

        let remaining = (7 - days.count % 7) % 7
        if remaining > 0,
           let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            
            let daysInNextMonth = numberOfDays(in: nextMonth)
            
            for day in 1...remaining {
                let validDay = min(day, daysInNextMonth)
                if let date = calendar.date(bySetting: .day, value: validDay, of: nextMonth) {
                    let isHoliday = calendar.isHoliday(date, in: holidayDates)
                    days.append(CalendarDay(day: validDay, date: date, isCurrentMonth: false, isHoliday: isHoliday))
                }
            }
        }

        return days
        
    }
    
    func numberOfDays(in date: Date) -> Int {
        Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    private func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDay = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDay)
    }
    
    func firstDayOfMonth() -> Date {
        let compoents = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        return Calendar.current.date(from: compoents) ?? Date()
    }
    
    func weekForDate(_ date: Date) -> [Date] {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: date) ?? date
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }
    
    func updateHolidayDates(from holidays: [Holiday]) {
        var newHolidays: Set<Date> = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        for holiday in holidays {
            let dateString = String(holiday.locdate)
            if let date = formatter.date(from: dateString) {
                newHolidays.insert(Calendar.current.startOfDay(for: date))
            }
        }
        self.holidayDates = newHolidays
    }
    
    public func changeSelectedDate(_ date: Date) {
        if calendar.isDate(selectedDate, inSameDayAs: date) {
            return
        } else {
            selectedDate = date
        }
    }
}

extension Calendar {
    func isHoliday(_ date: Date, in holidays: Set<Date>) -> Bool {
        let normalized = self.startOfDay(for: date)
        return holidays.contains(normalized)
    }
}
