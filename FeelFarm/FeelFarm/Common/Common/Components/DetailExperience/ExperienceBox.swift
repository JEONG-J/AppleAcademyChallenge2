//
//  ExperienceBox.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct ExperienceBox: View {
    
    let title: String
    let icon: Image
    @Binding var contents: String
    @Binding var isModify: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            topTitle
            
            TextEditor(text: $contents)
                .detailExperience(isModify: $isModify, text: $contents, background: Color.white)
                .shadow01()
                .frame(height: 280)
        })
    }
    
    private var topTitle: some View {
        Label(title: {
            Text(title)
                .font(.T20Semibold)
                .foregroundStyle(Color.black)
        }, icon: {
            icon
                .resizable()
                .frame(width: 40, height: 41)
        })
    }
}

#Preview {
    ExperienceBox(title: "작성된 경험", icon: Image(.experienceHappy), contents: .constant("오늘 나는 도메인으로 작성된 무엇무엇 무엇"), isModify: .constant(false))
}
