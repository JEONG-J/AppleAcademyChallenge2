//
//  CalendarDay.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
    let isHoliday: Bool
}
