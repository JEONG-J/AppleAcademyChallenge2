//
//  CustomNavigationBar.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let text: String?
    let action: () -> Void
    
    init(text: String?, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        ZStack {
            if let text = text {
                HStack {
                    Spacer()
                    
                    Text(text)
                        .font(.T20Semibold)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                }
            }
            
            HStack {
                    Button(action: {
                        action()
                    }, label: {
                        Image(.chevronNavi)
                    })
                    Spacer()
            }
        }
        .safeAreaPadding(.horizontal, 16)
    }
}
