//
//  DetailExperience.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct DetailExperienceView: View {
    
    @Bindable var viewModel: DetailExperienceViewModel
    @State var isModify: Bool = false
    @State var isShowDelete: Bool = false
    
    init(emotionData: any EmotionProtocol, container: DIContainer) {
        self.viewModel = .init(experienceData: emotionData, container: container)
    }
    
    var body: some View {
        VStack {
            if !viewModel.isLoading {
                ScrollView(.vertical, content: {
                    contents
                })
                Spacer()
                
                if viewModel.isCurrentUserData {
                    currentUserBottomBtn
                }
            } else {
                Spacer()
                
                ProgressView()
                    .controlSize(.regular)
                
                Spacer()
            }
        }
        .safeAreaPadding(.horizontal, 16)
        .safeAreaPadding(.top, 20)
        .alert("나의 경험 기록 삭제", isPresented: $isShowDelete, actions: {
            Button("취소", role: .cancel) { isShowDelete.toggle() }
            Button("삭제", role: .destructive) {
                viewModel.deleteEmotion()
            }
        }, message: {
            Text("기록된 경험을 삭제합니다.")
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .customToolbar(title: "경험 상세 화면", action: {
            viewModel.container.navigationRouter.pop()
        })
    }
    
    private var contents: some View {
        VStack(spacing: 64) {
            ExperienceBox(title: "작성된 경험", icon: viewModel.experienceData.emotion.potatoFace, contents: $viewModel.modifyText, isModify: $isModify)
            
            ExperienceBox(title: "감자도리 AI 편지", icon: Image(.logo), contents: $viewModel.experienceData.feedback, isModify: .constant(false))
        }
    }
    
    private var currentUserBottomBtn: some View {
        HStack {
            MainButton(buttonType: .delete, action: {
                isShowDelete.toggle()
            })
            
            Spacer()
            
            MainButton(buttonType: isModify ? .modifyCompleted : .modify, action: {
                self.isModify.toggle()
                
                if !isModify {
                    viewModel.getAIResponse()
                }
            })
        }
    }
}

#Preview {
    DetailExperienceView(emotionData: EmotionResponse(id: "0", emotion: .angry, content: "z", feedback: "asdaldkadlkasdjdlaskd", date: Date(), field: .design, sharePostId: "11"), container: DIContainer())
}
