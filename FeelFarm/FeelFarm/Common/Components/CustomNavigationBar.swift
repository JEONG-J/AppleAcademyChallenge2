//
//  CustomNavigationBar.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    let text: String?
    
    init(text: String?) {
        self.text = text
    }
    
    var body: some View {
        ZStack {
            if let text = text {
                HStack {
                    Spacer()
                    
                    Text(text)
                        .font(.T18medium)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                }
            }
            
            HStack {
                    Button(action: {
                        print("hello")
                    }, label: {
                        Image(.chevronNavi)
                    })
                    Spacer()
            }
        }
        .safeAreaPadding(.horizontal, 16)
    }
}

#Preview {
    CustomNavigationBar(text: "Domain 경험 생성")
}
