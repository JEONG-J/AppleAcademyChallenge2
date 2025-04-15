//
//  NoExpeirenceGuide.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct ExperienceGuide: View {
    
    enum GuideType {
        case none
        case existence
    }
    
    let guideType: GuideType
    let text: String
    
    init(guideType: GuideType, text: String) {
        self.guideType = guideType
        self.text = text
    }
    
    var body: some View {
        switch guideType {
        case .none:
            noneGuide
        case .existence:
            existenceGuide
        }
    }
    
    private var noneGuide: some View {
        Text(text)
            .font(.T14medium)
            .foregroundStyle(Color.gray07)
            .frame(maxWidth: .infinity, minHeight: 163)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow03()
            }
            .lineLimit(nil)
            .lineSpacing(2.5)
    }
    
    private var existenceGuide: some View {
        ZStack {
            Image(.versesBorder)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow03()
                }
            
                Text(text)
                    .frame(width: 284, height: 74)
                    .font(.T13medium)
                    .foregroundStyle(Color.gray07)
                    .lineLimit(nil)
                    .lineSpacing(2.5)
                    .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    ExperienceGuide(guideType: .existence, text: "오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!")
}
