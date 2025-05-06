//
//  EmotionChart.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

struct EmotionChartData: Identifiable {
    let id = UUID()
    let type: EmotionType
    let value: Int
}
