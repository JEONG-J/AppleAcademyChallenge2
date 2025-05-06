//
//  AIUseCaseProtocol.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation
import Moya
import Combine

protocol AIUseCaseProtocol {
    func getAI(model: AIModel) -> AnyPublisher<AIResponse, MoyaError>
}
