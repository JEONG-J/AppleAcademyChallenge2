//
//  CalendarView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct CalendarView: View {
    
    var viewModel: CalendarViewModel
    
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    var body: some View {
        VStack {
            CustomCalendar(viewModel: viewModel)
            
            SubCalendar(viewModel: viewModel)
        }
    }
}

#Preview {
    CalendarView(container: DIContainer())
}
