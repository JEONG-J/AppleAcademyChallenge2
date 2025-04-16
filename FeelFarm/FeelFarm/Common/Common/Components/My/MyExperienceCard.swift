//
//  MyExperienceCard.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct MyExperienceCard: View {
    
    let emotionReponse: EmotionResponse
    
    init(emotionReponse: EmotionResponse) {
        self.emotionReponse = emotionReponse
    }


    var body: some View {
        HStack(content: {
            emotionReponse.field.coverImage
                .resizable()
                .frame(width: 62, height: 93)
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16)
                )
            
            Spacer()
            
            Text(emotionReponse.content)
                .font(.T12medium)
                .foregroundStyle(Color.black)
                .lineLimit(nil)
                .lineSpacing(2.5)
                .multilineTextAlignment(.leading)
                .frame(height: 93)
            
            Spacer()
            
            VStack {
                Spacer()
                
                emotionReponse.emotion.potatoFace
                    .padding([.bottom, .trailing], 8)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: 93)
        .background {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.white)
                .shadow04()
        }
        .shadow04()
    }
}

#Preview {
    MyExperienceCard(emotionReponse: .init(id: "1", emotion: .happy, content: "오늘 피그마로 챌린지 디자인을 하는데 너무 죽을 거 같아요.. 근데 재밌네요 ㅎㅎ", feedback: "호호 어렵죠?", date: Date(), field: .design, sharePostId: "1"))
}
