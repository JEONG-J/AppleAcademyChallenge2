//
//  SplashView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack(alignment: .firstTextBaseline, spacing: 0, content: {
                Text("FeelFarm")
                    .font(.HeadLineLogo)
                    .foregroundStyle(Color.feelFarmOrange)
                
                Image(.logo)
                    .resizable()
                    .frame(width: 64, height: 66)
                
            })
            
            Spacer()
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            appFlowViewModel.checkAuthState()
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AppFlowViewModel())
}
