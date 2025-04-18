//
//  TabView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct FeelFarmTabView: View {
    
    @State var tabcase: TabCase = .home
    @State var myTabShowPlushSheet: Bool = false
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destination) {
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
            .navigationDestination(for: NavigationDestination.self, destination: { destination in
                NavigationRoutingView(destination: destination)
                    .environmentObject(container)
            })
        }
    }
    
    @ViewBuilder
        private func tabView(for tab: TabCase) -> some View {
            Group {
                switch tab {
                case .home:
                    HomeView(tabCase: $tabcase, myTabShowPlushSheet: $myTabShowPlushSheet)
                case .my:
                    CalendarView(showAddExperience: $myTabShowPlushSheet, container: container)
                case .share:
                    ShareView()
                        .navigationTitle("Starbucks® Online Store")
                        .navigationBarTitleDisplayMode(.inline) // 상단에 타이틀을 작게 표시
                }
            }
            .environmentObject(container)
        }
}

#Preview("FeelFarmTabView") {
    FeelFarmTabView()
        .environmentObject(DIContainer())
}

#Preview("SplashView") {
    SplashView()
        .environmentObject(AppFlowViewModel())
}

#Preview("CreateNicknameView") {
    CreateNicknameView()
        .environmentObject(AppFlowViewModel())
}
