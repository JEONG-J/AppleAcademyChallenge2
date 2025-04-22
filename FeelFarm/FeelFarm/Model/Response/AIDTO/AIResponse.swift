//
//  AIResponse.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation

struct AIResponse: Codable {
    let model: String
    let createdAt: String
    let response: String
    let done: Bool
    let doneReason: String
    let context: [Int]
    let totalDuration: Int
    let loadDuration: Int
    let promptEvalCount: Int
    let promptEvalDuration: Int
    let evalCount: Int
    let evalDuration: Int
    
    enum CodingKeys: String, CodingKey {
        case model
        case createdAt = "created_at"
        case response
        case done
        case doneReason = "done_reason"
        case context
        case totalDuration = "total_duration"
        case loadDuration = "load_duration"
        case promptEvalCount = "prompt_eval_count"
        case promptEvalDuration = "prompt_eval_duration"
        case evalCount = "eval_count"
        case evalDuration = "eval_duration"
    }
}
