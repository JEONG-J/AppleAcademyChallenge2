//
//  LearnerCard.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import SwiftUI

struct LearnerCard: View {
    
    let sharedEmotion: SharedEmotion
    
    init(sharedEmotion: SharedEmotion) {
        self.sharedEmotion = sharedEmotion
    }
    
    var body: some View {
        VStack(spacing: 8, content: {
            sharedEmotion.field.coverImage
                .resizable()
                .frame(width: 82, height: 123)
            
            VStack(spacing: 4, content: {
                Text(sharedEmotion.nickname)
                    .font(.T16bold)
                    .foregroundStyle(Color.gray07)
                
                Text(sharedEmotion.content.split(separator: "").joined(separator: "\u{200B}"))
                    .font(.T12medium)
                    .foregroundStyle(Color.gray06)
                    .lineLimit(2)
                    .lineSpacing(1.6)
            })
        })
        .frame(width: 82)
    }
}

#Preview {
    LearnerCard(sharedEmotion: .init(id: "Aaron", content: "피그마 사용법을 공부했는데 참고하기 너무 어려웠어요.", emotion: .angry, feedback: "열심히해", field: .domain, nickname: "제옹", uid: "awvs123", date: .now))
}
