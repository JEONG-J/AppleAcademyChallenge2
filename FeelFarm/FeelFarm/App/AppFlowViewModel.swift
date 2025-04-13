//
//  AppFlowViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation

class AppFlowViewModel: ObservableObject {
    
    @Published private var appState: AppState = .onboarding
    
    enum AppState {
        case onboarding
        case createProfile
        case tabbar
    }
}
