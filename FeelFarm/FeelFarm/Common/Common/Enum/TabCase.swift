//
//  TabCase.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import SwiftUI

enum TabCase: String, CaseIterable {
    case home = "Home"
    case my = "My"
    case share = "Share"
    
    var icon: Image {
        switch self {
        case .home:
            return .init(.homeTab)
        case .my:
            return .init(.myTab)
        case .share:
            return .init(.shareTab)
        }
    }
}

