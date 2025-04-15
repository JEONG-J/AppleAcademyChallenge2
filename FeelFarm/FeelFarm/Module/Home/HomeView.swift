//
//  HomeView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel: HomeViewModel = .init()
    
    var body: some View {
        middleContents
    }
    
    /// 상단 컨텐츠
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            SelecteEmotion(viewModel: viewModel)
            
            if viewModel.isEmotionPickerPresented {
                EmotionPicker(viewModel: viewModel)
            }
            
            ExperienceGuide(guideType: returnGuidType(), text: "하하하")
        })
        .animation(.easeInOut, value: viewModel.isEmotionPickerPresented)
        .safeAreaPadding(.horizontal, 16)
    }
    
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text("러너들의 경험 연결고리 🌟")
                .font(.T20bold)
                .foregroundStyle(Color.black)
            
            if let sharedEmotions = viewModel.sharedEmotion {
                ScrollView(.horizontal, content: {
                    LazyHStack(spacing: 16, pinnedViews: .sectionHeaders, content: {
                        ForEach(sharedEmotions, id: \.id) { sharedEmotion in
                            LearnerCard(sharedEmotion: sharedEmotion)
                        }
                    })
                })
            } else {
                ExperienceGuide(guideType: .none, text: "아직 공유된 러너들의 경험이 없어요. \n첫 번째 경험을 남겨보는 건 어때요?")
            }
        })
    }
}

extension HomeView {
    /// 상단 본인 감정 경험 유/무 판단
    /// - Returns: 뷰 가이드 타입으로 반환
    private func returnGuidType() -> ExperienceGuide.GuideType {
        if viewModel.emotionReponse == nil {
            return .none
        } else {
            return .existence
        }
    }
    
}

#Preview {
    HomeView()
}

