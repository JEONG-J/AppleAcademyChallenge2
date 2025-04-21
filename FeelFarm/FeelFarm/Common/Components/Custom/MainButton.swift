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
                .padding(.bottom, 15)
        })
    }
    
    enum ButtonType {
        case modify
        case modifyCompleted
        case createOn
        case createOff
        case delete
        
        var text: String {
            switch self {
            case .modify:
                return "수정하기"
            case .modifyCompleted:
                return "수정 완료"
            case .createOn, .createOff:
                return "생성하기"
            case .delete:
                return "삭제하기"
            }
        }
        
        var background: Color {
            switch self {
            case .createOn, .modify, .modifyCompleted:
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
