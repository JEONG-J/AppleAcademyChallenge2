//
//  CalendarView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import SwiftUI

struct CustomCalendar: View {
    
    @Bindable var viewModel: CalendarViewModel
    
    var body: some View {
        VStack(spacing: 24, content: {
            hedarController
            
            calendarView
        })
        .padding(.vertical, 30)
        .padding(.horizontal, 16)
        .background(Color.white)
        .task {
            viewModel.getHolidayNeed()
        }
        .onChange(of: viewModel.currentMonthYear, { _, _ in
            viewModel.getHolidayNeed()
        })
    }
    
    private var hedarController: some View {
        HStack(spacing: 47, content: {
            Button(action: {
                viewModel.changeMonth(by: -1)
            }, label: {
                Image(.calendarLeft)
            })
            
            Text(viewModel.currentMonth, formatter: calendarHeaderDateFormatter)
                .font(.T18medium)
                .foregroundStyle(Color.black)
            
            
            Button(action: {
                viewModel.changeMonth(by: 1)
            }, label: {
                Image(.calendarRight)
            })
        })
    }
    
    private var calendarView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 5, content: {
            ForEach(localizedWeekdaySymbols.indices, id: \.self) { index in
                Text(localizedWeekdaySymbols[index])
                    .foregroundStyle(index == 0 ? Color.holiday : index == 6 ? Color.saturday : Color.gray05)
                    .frame(maxWidth: .infinity)
                    .font(.T14Semibold)
            }
            .padding(.bottom, 30)
            
            ForEach(viewModel.daysForCurrentGrid(), id: \.date) { calendarDay in
                let isSelectedDate = viewModel.calendar.isDate(calendarDay.date, inSameDayAs: viewModel.selectedDate)
                Cell(calendarDay: calendarDay, isSelected: isSelectedDate, viewModel: viewModel)
                    .onTapGesture {
                        print(calendarDay)
                    }
            }
        })
        .frame(height: 250, alignment: .top)
    }
    
    let localizedWeekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.shortWeekdaySymbols ?? []
    }()
    
    let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter
    }()
}

#Preview {
    CustomCalendar(viewModel: .init(container: DIContainer()))
}
