//
//  TopStatus.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct TopStatus: View {
    
    let text: String
    let action: (() -> Void)?
    
    init(text: String, action: (() -> Void)?) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.T24bold)
                .foregroundStyle(Color.black)
            
            Spacer()
            
            if let action = action {
                Button(action: {
                    action()
                }, label: {
                    Image(.plus)
                })
            }
        }
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .safeAreaPadding(.horizontal, 16)
        .safeAreaPadding(.bottom, 5)
        .padding(.top, 25)
        .background(Color.white)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TopStatus(text: "나의 경험", action: {
        print("Hello")
    })
}
