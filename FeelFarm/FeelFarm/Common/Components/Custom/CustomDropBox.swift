//
//  CustomDrobBox.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/17/25.
//

import SwiftUI

struct CustomDropBox: View {
    
    @State var showDrobBox: Bool = false
    @Bindable var viewModel: CreateExperienceViewModel
    
    var body: some View {
           ZStack(alignment: .top) {
               mainControl

               if showDrobBox {
                   dropBox
                       .offset(y: 54)
                       .zIndex(1)
               }
           }
           .frame(minHeight: 222, alignment: .top)
       }
    
    private var mainControl: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.4)) {
                showDrobBox.toggle()
            }
        }, label: {
            HStack {
                if viewModel.selectedEmotion == nil {
                    Text("감정 선택")
                        .font(.T14Regular)
                        .foregroundStyle(Color.gray05)
                } else {
                    viewModel.selectedEmotion?.createExperience
                }
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 12, height: 8)
                    .foregroundStyle(Color.gray03)
            }
            .frame(width: 138, height: 20)
            .padding(.horizontal, 25)
            .padding(.vertical, 12)
            .background(content: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.clear)
                    .stroke(Color.gray03, style: .init(lineWidth: 1))
            })
        })
    }
    
    private var dropBox: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(EmotionType.allCases, id: \.self) { emotion in
                createMenu(emotion: emotion)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 5)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .stroke(Color.gray03, style: .init(lineWidth: 1))
        }
    }
    
    private func createMenu(emotion: EmotionType) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.selectedEmotion = emotion
                showDrobBox = false
            }
        }, label: {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.selectedEmotion == emotion ? Color.prinaryLightActive : Color.clear)
                    .frame(width: 170, height: 42)
                
                emotion.createExperience
                    .padding(.leading, 16)
            }
        })
    }
}

#Preview {
    CustomDropBox(viewModel: .init(fieldType: .design, container: DIContainer()))
}
