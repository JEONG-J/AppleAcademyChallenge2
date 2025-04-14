//
//  Shadow.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation
import SwiftUI

struct Shadow01: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}

struct Shadow02: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

struct Shadow03: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.04), radius: 2, x: 0, y: 3)
            .shadow(color: .black.opacity(0.04), radius: 2, x: 3, y: 0)
    }
}

struct Shadow04: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
    }
}

extension View {
    func shadow01() -> some View {
        self.modifier(Shadow01())
    }
    
    func shadow02() -> some View {
        self.modifier(Shadow02())
    }
    
    func shadow03() -> some View {
        self.modifier(Shadow03())
    }
    
    func shadow04() -> some View {
        self.modifier(Shadow04())
    }
}
