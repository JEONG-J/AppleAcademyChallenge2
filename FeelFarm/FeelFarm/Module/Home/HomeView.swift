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
        topContents
    }
    
    private var topContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            SelecteEmotion(viewModel: viewModel)
            
            if viewModel.isEmotionPickerPresented {
                EmotionPicker(viewModel: viewModel)
            }
            
            ExperienceGuide(guideType: returnGuidType(), text: "하하하")
        })
        .animation(.easeInOut, value: viewModel.isEmotionPickerPresented)
    }
    
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
