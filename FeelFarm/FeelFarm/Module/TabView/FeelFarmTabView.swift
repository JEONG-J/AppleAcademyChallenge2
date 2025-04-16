//
//  TabView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct FeelFarmTabView: View {
    
    @State var tabcase: TabCase = .home
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        TabView(selection: $tabcase, content: {
            ForEach(TabCase.allCases, id: \.rawValue) { tab in
                Tab(value: tab, content: {
                    tabView(for: tab)
                        .tag(tab)
                }, label: {
                    VStack(spacing: 5, content: {
                        tab.icon
                            .renderingMode(.template)
                        
                        Text(tab.rawValue)
                            .font(.T12medium)
                    })
                    
                })
            }
        })
        .tint(Color.feelFarmOrange)
    }
    
    @ViewBuilder
        private func tabView(for tab: TabCase) -> some View {
            Group {
                switch tab {
                case .home:
                    HomeView()
                case .my:
                    CalendarView(container: container)
                case .share:
                    ShareView()
                }
            }
            .environmentObject(container)
        }
}

#Preview("FeelFarmTabView") {
    FeelFarmTabView()
        .environmentObject(DIContainer())
        .environmentObject(AppFlowViewModel())
}

#Preview("SplashView") {
    SplashView()
        .environmentObject(AppFlowViewModel())
}

#Preview("CreateNicknameView") {
    CreateNicknameView()
        .environmentObject(AppFlowViewModel())
}
