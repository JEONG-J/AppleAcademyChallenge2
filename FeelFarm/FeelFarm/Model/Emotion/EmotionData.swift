//
//  EmotionData.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import SwiftUI

struct EmotionData: Identifiable {
    var id: UUID = .init()
    var emotionType: EmotionType
}

final class EmotionDataList {
    static let emotionList: [EmotionData] = [
        .init(emotionType: .happy),
        .init(emotionType: .angry),
        .init(emotionType: .inspiration),
        .init(emotionType: .sad),
        .init(emotionType: .touched),
    ]
}
