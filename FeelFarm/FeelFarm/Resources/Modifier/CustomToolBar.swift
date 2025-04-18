//
//  CustomToolBar.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/18/25.
//

import Foundation
import SwiftUI

struct CustomToolBar: ViewModifier {
    let title: String?
    let action: () -> Void
    
    init(title: String?, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .navigation, content: {
                    Button(action: {
                        action()
                    }, label: {
                        Image(.chevronNavi)
                    })
                })
                
                if let title = self.title {
                    ToolbarItem(placement: .principal, content: {
                        Text(title)
                            .font(.T18Semibold)
                            .foregroundStyle(Color.black)
                    })
                }
            })
    }
}

extension View {
    func customToolbar(
        title: String?,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(CustomToolBar(title: title, action: action))
    }
}
