//
//  HomeView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    var viewModel: HomeViewModel = .init()
    @EnvironmentObject var container: DIContainer
    @Binding var tabCase: TabCase
    @Binding var myTabShowPlushSheet: Bool
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                CustomProgressView()
            } else {
                ScrollView(.vertical, content: {
                    VStack(spacing: 40) {
                        userProfile
                        topContents
                        middleContents
                        EmotionChartView(viewModel: viewModel, tabCase: $tabCase, myTabShowPlushSheet: $myTabShowPlushSheet)
                            .environmentObject(container)
                    }
                    .safeAreaPadding(.horizontal, 16)
                })
                .safeAreaPadding(.bottom, 20)
                .background(Color.white)
            }
        }
        .task {
            viewModel.loadAllData()
        }
    }
    
    private var userProfile: some View {
        HStack {
            Text("FeelFarm")
                .font(.mitr(type: .bold, size: 28))
                .foregroundStyle(Color.feelFarmOrange)
            
            Spacer()
            
            userProfileImage
        }
    }
    
    @ViewBuilder
    private var userProfileImage: some View {
        if let profileURL = viewModel.profileURL,
           let url = URL(string: profileURL) {
            KFImage(url)
                .placeholder({
                    ProgressView()
                }).retry(maxCount: 2, interval: .seconds(2))
                .onFailureImage(.profilePotato)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
    
    /// 상단 컨텐츠
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            SelecteEmotion(viewModel: viewModel)
            
            if viewModel.isEmotionPickerPresented {
                EmotionPicker(viewModel: viewModel)
            }
            
            ExperienceGuide(guideType: returnGuidType(), text: viewModel.emotionReponse?.content ?? "기록된 경험이 없습니다. 경험을 작성해주세요")
        })
        .animation(.easeInOut, value: viewModel.isEmotionPickerPresented)
    }
    
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text("러너들의 경험 연결고리 🌟")
                .font(.T20bold)
                .foregroundStyle(Color.black)
            
            if let sharedEmotions = viewModel.sharedEmotion {
                ScrollView(.horizontal, content: {
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 1), spacing: 16, content: {
                        ForEach(sharedEmotions, id: \.id) { sharedEmotion in
                            LearnerCard(sharedEmotion: sharedEmotion)
                                .onTapGesture {
                                    print("러너들의 경험 공유 클릭")
                                    container.navigationRouter.push(to: .shareToDetailExperience(experienceData: sharedEmotion))
                                    print(container.navigationRouter.destination)
                                }
                        }
                    })
                    .frame(height: 200, alignment: .top)
                })
                .scrollIndicators(.visible)
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
    HomeView(viewModel: .init(), tabCase: .constant(.home), myTabShowPlushSheet: .constant(false))
        .environmentObject(DIContainer())
}
