//
//  EmotionType.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import SwiftUI

enum EmotionType: String, CaseIterable {
    case happy
    case sad
    case inspiration
    case touched
    case angry
    
    var emotionIcon: Image {
        switch self {
        case .happy:
            return .init(.happyEmotion)
        case .sad:
            return .init(.sadEmotion)
        case .inspiration:
            return .init(.inspirationEmotion)
        case .touched:
            return .init(.touchedEmotion)
        case .angry:
            return .init(.angryEmotion)
        }
    }
    
    var potatoFace: Image {
        switch self {
        case .happy:
            return .init(.experienceHappy)
        case .sad:
            return .init(.experienceSad)
        case .inspiration:
            return .init(.experienceInsp)
        case .touched:
            return .init(.experienceTouch)
        case .angry:
            return .init(.experienceAngry)
        }
    }
    
    var emotionColor: Color {
        switch self {
        case .happy:
            return Color.happy
        case .sad:
            return Color.sad
        case .inspiration:
            return Color.inspiration
        case .touched:
            return Color.touched
        case .angry:
            return Color.angry
        }
    }
    
    var emotionKorean: String {
        switch self {
        case .happy:
            return "기쁨"
        case .sad:
            return "슬픔"
        case .inspiration:
            return "영감"
        case .touched:
            return "감동"
        case .angry:
            return "분노"
        }
    }
}
