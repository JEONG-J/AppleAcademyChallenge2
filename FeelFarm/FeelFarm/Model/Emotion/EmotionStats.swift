//
//  EmotionStats.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

struct EmotionStats {
    var values: [EmotionType: Int]

    init?(from data: [String: Any]) {
        var result: [EmotionType: Int] = [:]
        for type in EmotionType.allCases {
            result[type] = data[type.rawValue] as? Int ?? 0
        }
        self.values = result
    }
}
