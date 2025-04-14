//
//  MainButton.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct MainButton: View {
    
    let buttonType: ButtonType
    let action: () -> Void
    
    init(buttonType: ButtonType, action: @escaping () -> Void) {
        self.buttonType = buttonType
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(buttonType.text)
                .font(.T18Semibold)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, minHeight: 49)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(buttonType.background)
                }
        })
    }
    
    enum ButtonType {
        case createOn
        case createOff
        case delete
        
        var text: String {
            switch self {
            case .createOn, .createOff:
                return "생성하기"
            case .delete:
                return "삭제하기"
            }
        }
        
        var background: Color {
            switch self {
            case .createOn:
                return .feelFarmOrange
            case .createOff:
                return .gray06
            case .delete:
                return .red
            }
        }
    }
}

#Preview {
    MainButton(buttonType: .createOn, action: {
        print("hello")
    })
}
