//
//  NavigationRoutable.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation

protocol NavigationRoutable {
    var destination: [NavigationDestination] { get set }
    func push(to view: NavigationDestination)
    func pop()
    func popToRootViwe()
}


final class NavigationRouter: NavigationRoutable, ObservableObject {
    var destination: [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destination.append(view)
    }
    
    func pop() {
        _ = destination.popLast()
    }
    
    func popToRootViwe() {
        destination.removeAll()
    }
}
