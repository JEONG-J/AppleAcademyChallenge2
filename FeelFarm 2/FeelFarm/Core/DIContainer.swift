//
//  DIContainer.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation

class DIContainer: ObservableObject {
    @Published var navigationRouter: NavigationRouter
    let userCaseProvider: UseCaseProvider
    
    init(
        navigationRouter: NavigationRouter = .init(),
        usecaseProvider: UseCaseProvider = .init()
    ) {
        self.navigationRouter = navigationRouter
        self.userCaseProvider = usecaseProvider
    }
}
