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
            ScrollView(.vertical, content: {
                contents
            })
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .safeAreaPadding(.top, 20)
        .alert("나의 경험 기록 삭제", isPresented: $isShowDelete, actions: {
            Button("취소", role: .cancel) { isShowDelete.toggle() }
            Button("삭제", role: .destructive) {
                viewModel.container.navigationRouter.pop()
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
            ExperienceBox(title: "작성된 경험", icon: viewModel.experienceData.emotion.potatoFace, contents: $viewModel.experienceData.content, isModify: $isModify)
                .disabled(!isModify)
            
            ExperienceBox(title: "감자도리 AI 편지", icon: Image(.logo), contents: $viewModel.experienceData.feedback, isModify: $isModify)
            
            Spacer()
            
            bottomBtn
        }
    }
    
    private var bottomBtn: some View {
        HStack {
            MainButton(buttonType: .delete, action: {
                isShowDelete.toggle()
            })
            Spacer()
            
            MainButton(buttonType: isModify ? .modify : .modifyCompleted, action: {
                self.isModify.toggle()
            })
        }
    }
}
