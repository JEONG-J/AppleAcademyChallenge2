//
//  CellView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import SwiftUI

struct Cell: View {
    
    var calendarDay: CalendarDay
    var isSelected: Bool
    @Bindable var viewModel: CalendarViewModel

    
    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(Color.prinaryLightActive)
                    .frame(width: 26, height: 27)
                    .transition(.scale.combined(with: .opacity))
            }

            Text("\(calendarDay.day)")
                .font(.T14Semibold)
                .foregroundStyle(textColor)
                .animation(.easeInOut(duration: 0.2), value: viewModel.selectedDate)
        }
        .frame(height: 30)
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0)) {
                viewModel.changeSelectedDate(calendarDay.date)
            }
        }
    }
    
    private var textColor: Color {
        if calendarDay.isHoliday {
            return Color.holiday
        } else if calendarDay.isCurrentMonth {
            return Color.gray05
        } else {
            return Color.clear
        }
    }
}
