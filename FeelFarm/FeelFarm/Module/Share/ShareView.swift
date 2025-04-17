//
//  ShareView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct ShareView: View {
    
    @Bindable var viewModel: ShareViewModel = .init()
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, content: {
                VStack(alignment: .leading, spacing: 33, content: {
                    CustomSegment<FieldType>(selectedSegment: $viewModel.selectedSegment)
                    
                    if !viewModel.sharedData.isEmpty {
                        contents
                    } else {
                        noExperienceData
                    }
                })
            })
            .safeAreaPadding(.horizontal, 16)
            .contentMargins(.top, 20)
            .background(Color.white)
            .navigationTitle(
                Text("Runner Stories")
                    .font(.T20Semibold)
            )
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    @ViewBuilder
    private var noExperienceData: some View {
        Spacer()
        
        VStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 94, height: 97)
            
            Text("아직 공유된 경험이 없어요! \n누군가의 오늘이 이곳을 채워주길 기다리고 있어요!")
                .font(.T18Semibold)
                .foregroundStyle(Color.gray05)
                .lineLimit(nil)
                .lineSpacing(2.5)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
        }
        Spacer()
    }
    
    private var contents: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 10) {
            ForEach(viewModel.sharedData.indices, id: \.self) { index in
                let shareData = viewModel.sharedData[index]
                
                VStack(spacing: 10) {
                    LearnerExperienceCard(shareData: shareData)
                        .onTapGesture {
                            container.navigationRouter.push(to: .shareToDetailExperience(experienceData: viewModel.sharedData[index]))
                        }
                    
                    if index < viewModel.sharedData.count - 1 {
                        Divider()
                            .foregroundStyle(Color.gray03)
                            .frame(maxWidth: .infinity,  maxHeight: 1)
                    }
                }
            }
        }
    }
}

#Preview {
    ShareView()
        .environmentObject(DIContainer())
}
