//
//  AIServiceProtocol.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation
import Moya
import Combine

protocol AIServiceProtocol {
    func getAIData(model: AIModel) -> AnyPublisher<AIResponse, MoyaError>
}
