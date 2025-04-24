//
//  LoadingModifier.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation
import SwiftUI

struct LoadingModifier: ViewModifier {
    
    enum LoadingTextType: String {
        case experience = "감자도리 AI가 열심히 편지를 쓰는 중이에요! \n추억도 함께 저장 중이랍니다 💌"
        case profile = "프로필이 생설될 때까지 기다려주세요 ⏰"
    }
    
    let isLoading: Bool
    let loadingType: LoadingTextType
    
    func body(content: Content) -> some View {
        content
            .overlay(content: {
                
                if isLoading {
                    ZStack(content: {
                        Color.black.opacity(0.75)
                        
                        ProgressView(label: {
                            Text(loadingType.rawValue)
                                .lineLimit(2)
                                .lineSpacing(2.5)
                                .multilineTextAlignment(.center)
                                .font(.T16medium)
                                .foregroundStyle(Color.white)
                        })
                        
                        .tint(Color.feelFarmOrange)
                        .controlSize(.large)
                        .tint(Color.white)
                    })
                    .ignoresSafeArea()
                }
            })
    }
}

extension View {
    func loadingOverlay(isLoading: Bool, loadingType: LoadingModifier.LoadingTextType) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading, loadingType: loadingType))
    }
}
