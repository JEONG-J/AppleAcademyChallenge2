//
//  SelecteEmotion.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct SelecteEmotion: View {
    
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        HStack(content: {
            makeGuideText(text: "오늘의 감정은")
            
            Spacer()
            
            guideImage
            
            Spacer()
            
            makeGuideText(text: "입니다.")
        })
        .frame(maxWidth: .infinity)
    }
    
    private func makeGuideText(text: String) -> some View {
        Text(text)
            .font(.T22bold)
            .foregroundStyle(Color.black)
    }
    
    private var guideImage: some View {
        
            Button(action: {
                withAnimation(.easeInOut(duration: 0.8)) {
                    viewModel.isEmotionPickerPresented.toggle()
                }
            }, label: {
                ZStack(alignment: .top, content: {
                Image(.emotionBackground)
                    HStack(content: {
                        viewModel.emotionType.potatoFace
                        
                        Spacer()
                        
                        viewModel.emotionType.emotionIcon
                    })
                    .frame(width: 91)
            })
        })
    }
}

#Preview {
    SelecteEmotion(viewModel: .init())
}
