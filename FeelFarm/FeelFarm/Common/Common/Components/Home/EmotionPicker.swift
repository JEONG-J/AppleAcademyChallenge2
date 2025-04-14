//
//  EmotonStack.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct EmotionPicker: View {
    
    let emotionList = EmotionDataList.emotionList
    @Bindable var viewModel: HomeViewModel
    @State var isEmotionPickerViewAnimation: Bool = false
    
    var body: some View {
        emotionPickerView
            .opacity(isEmotionPickerViewAnimation ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isEmotionPickerViewAnimation = true
                }
            }
            .onDisappear {
                withAnimation(.bouncy(duration: 1.5)) {
                    isEmotionPickerViewAnimation = false
                }
            }
    }
    private var emotionPickerView: some View {
        HStack {
            Spacer()
            
            ForEach(emotionList, id: \.id) { emotion in
                Button(action: {
                    viewModel.emotionType = emotion.emotionType
                    print(emotion)
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
