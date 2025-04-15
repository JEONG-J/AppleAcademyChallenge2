//
//  EmotonStack.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI
import FirebaseAuth

struct EmotionPicker: View {
    
    let emotionList = EmotionDataList.emotionList
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        emotionPickerView
            .opacity(viewModel.isEmotionPickerViewAnimation ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.isEmotionPickerViewAnimation = true
                }
            }
            .onDisappear {
                withAnimation(.bouncy(duration: 1.5)) {
                    viewModel.isEmotionPickerViewAnimation = false
                }
            }
    }
    private var emotionPickerView: some View {
        HStack {
            Spacer()
            
            ForEach(emotionList, id: \.id) { emotion in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.emotionType = emotion.emotionType
                        viewModel.isEmotionPickerViewAnimation.toggle()
                        viewModel.isEmotionPickerPresented.toggle()
                        viewModel.getLatestEmotion(of: emotion.emotionType)
                    }
                }, label: {
                    emotion.emotionType.emotionIcon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 20)
                        .padding(5)
                })
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray03, lineWidth: 1)
        })
    }
}

#Preview {
    EmotionPicker(viewModel: HomeViewModel())
}
