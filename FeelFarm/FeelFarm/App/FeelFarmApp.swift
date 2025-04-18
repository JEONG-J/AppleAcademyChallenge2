//
//  FeelFarmApp.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import SwiftUI
import FirebaseCore

@main
struct FeelFarmApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init()
    @StateObject var appFlowViewModel: AppFlowViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            FeelFarmTabView()
                .environmentObject(container)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
