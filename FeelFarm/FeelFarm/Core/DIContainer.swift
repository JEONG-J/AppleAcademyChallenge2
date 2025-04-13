//
//  DIContainer.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation

class DIContainer: ObservableObject {
    let navigationRouter: NavigationRouter
    
    init(navigationRouter: NavigationRouter = .init()) {
        self.navigationRouter = navigationRouter
    }
}
