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
    
    init(experienceData: EmotionResponse, container: DIContainer) {
        self.viewModel = .init(experienceData: experienceData, container: container)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(text: "경험 상세 화면", action: {
                viewModel.container.navigationRouter.pop()
            })
            
            ScrollView(.vertical, content: {
                contents
            })
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .contentMargins(.bottom, 20)
        }
        .alert("나의 경험 기록 삭제", isPresented: $isShowDelete, actions: {
            Button("취소", role: .cancel) { isShowDelete.toggle() }
            Button("삭제", role: .destructive) { print("삭제") }
        }, message: {
            Text("기록된 경험을 삭제합니다.")
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
            
            MainButton(buttonType: .createOn, action: {
                print("수정하기")
            })
        }
    }
}

#Preview {
    DetailExperienceView(experienceData: .init(id: "1", emotion: .happy, content: "오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오늘 나는 도메인으로 작성된 무엇무엇오", feedback: "오늘도 힘내요 ~ 화이팅 이라구", date: Date(), field: .design, sharePostId: "11"), container: DIContainer())
}
