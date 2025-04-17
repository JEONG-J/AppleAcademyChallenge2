//
//  NavigationDestination.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation

enum NavigationDestination: Equatable {
    case createExperience(field: FieldType)
    case shareToDetailExperience(experienceData: SharedEmotion)
    case myToDetailExpereince(experienceData: EmotionResponse)
}
