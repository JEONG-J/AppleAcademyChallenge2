//
//  AIModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation

struct AIModel: Codable {
    let model: String
    let system: String
    let prompt: String
    let stream: Bool
}
