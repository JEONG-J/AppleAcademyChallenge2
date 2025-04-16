//
//  SubCalendar.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import SwiftUI

struct SubCalendar: View {
    
    @Bindable var viewModel: CalendarViewModel
    
    var body: some View {
        weeokDateView
    }
    
    private var weeokDateView: some View {
        let targetDate = viewModel.selectedDate
        let weekDates = viewModel.weekForDate(targetDate)
        
        return LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1), spacing: 0) {
            ForEach(weekDates, id: \.self) { date in
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        viewModel.selectedDate = date
                    }
                    print(viewModel.selectedDate)
                    print(date)
                }, label: {
                    weekDate(date: date)
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(Color.white)
    }
    
    private func weekDate(date: Date) -> some View {
        VStack(spacing: 10) {
            Group {
                Text(dayFormatter.string(from: date))
                Text(weekdayFormatter.string(from: date))
            }
            .font(date == viewModel.selectedDate ? .T14Semibold : .T13Regular)
            .foregroundStyle(date == viewModel.selectedDate ? Color.white : Color.gray04)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background {
            if date == viewModel.selectedDate {
                Rectangle()
                    .fill(Color.feelFarmOrange)
                    .mask(alignment: .center, {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    })
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: viewModel.selectedDate)
            } else {
                Color.clear
            }
        }
        
    }
    
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d"
        return formatter
    }()
    
    let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter
    }()
}

#Preview {
    SubCalendar(viewModel: .init(container: DIContainer()))
}
