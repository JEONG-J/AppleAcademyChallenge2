//
//  LearnerExperienceCard.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct LearnerExperienceCard: View {
    
    let shareData: SharedEmotion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            shareData.emotion.potatoFace
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
            Text(shareData.content)
                .font(.T16Regular)
                .foregroundStyle(Color.black)
            
            HStack(spacing: 6, content: {
                Text(shareData.nickname)
                    .font(.T14medium)
                    .foregroundStyle(Color.gray05)
                    .lineLimit(nil)
                    .lineSpacing(2.5)
                    .multilineTextAlignment(.leading)
                
               Text("|")
                    .font(.T14medium)
                    .foregroundStyle(Color.gray05)
                
                Text("작성일: \(formatterDate(shareData.date))")
                    .font(.T14medium)
                    .foregroundStyle(Color.gray04)
            })
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        })
        .frame(maxWidth: .infinity, minHeight: 103)
            
    }
    
    func formatterDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd"
        
        let dateString = formatter.string(from: date)
        return dateString
    }
}

#Preview {
    LearnerExperienceCard(shareData: .init(id: "123", content: "개발 너무 어려워서 못하겠어용 흥행행 잉잉잉 으아아아아아아아아미미ㅣ잉이미ㅣ이이", emotion: .happy, feedback: "으아아", field: .domain, nickname: "쿨냥", uid: "~11", date: Date()))
}
