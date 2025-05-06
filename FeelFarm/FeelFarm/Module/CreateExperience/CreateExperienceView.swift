//
//  CreateExperience.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct CreateExperienceView: View {
    
    @Bindable var viewModel: CreateExperienceViewModel
    
    init(fieldType: FieldType, container: DIContainer) {
        self.viewModel = .init(fieldType: fieldType, container: container)
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                
                makeTextView(text: "오늘 어떤 순간이 마음에 남았나요?")
                
                ZStack(alignment: .topLeading) {
                    CustomDropBox(viewModel: viewModel).zIndex(1)
                    
                    secondContents.zIndex(0)
                        .offset(y: 80)
                }
                
                Spacer()
                
                MainButton(buttonType: .createOn, action: {
                    viewModel.getAIResponse()
                })
                .padding(.bottom, 20)
            }
            .loadingOverlay(isLoading: viewModel.isLoading, loadingType: .experience)
            .safeAreaPadding(.horizontal, 16)
            .navigationBarBackButtonHidden()
            .task {
                UIApplication.shared.hideKeyboard()
            }
            .customToolbar(title: "\(viewModel.fieldType.titleEnglish) 경험 생성", action: {
                viewModel.container.navigationRouter.pop()
            })
            .offset(y: 20)
    }
    
    private var secondContents: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            makeTextView(text: "오늘 하루 어떤 경험이 있었나요?")
            
            TextEditor(text: $viewModel.textEdit)
                .createExperience(text: $viewModel.textEdit, placeholder: "기억에 남는 오늘의 순간, 마음을 스친 생각, 혹은 아무 말이라도 좋아요.\n특별한 일이 없어도 괜찮아요. 소소한 기분의 변화, 스쳐 지나간 한마디도\n당신의 오늘을 보여주는 소중한 조각이니까요.\n\n망설이지 말고, 지금 떠오르는 그 순간을 조심스럽게 적어보세요.\n글을 남기면 귀여운 감자도리 AI가 따뜻한 응원의 말을 전해줄 거예요!", maxTextCount: 100, background: Color.gray01)
                .frame(maxHeight: 250)
        })
    }
    
    private func makeTextView(text: String) -> some View {
        Text(text)
            .font(.T20bold)
            .foregroundStyle(Color.black)
    }
}

#Preview {
    CreateExperienceView(fieldType: .design, container: DIContainer())
}
