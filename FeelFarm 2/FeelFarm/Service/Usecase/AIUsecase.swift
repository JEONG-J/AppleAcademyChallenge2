//
//  AIUseCase.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

class AIUsecase: AIUseCaseProtocol {
    private let service: AIServiceProtocol
    
    init(service: AIServiceProtocol = AIService()) {
        self.service = service
    }
    
    func getAI(model: AIModel) -> AnyPublisher<AIResponse, MoyaError> {
        return service.getAIData(model: model)
    }
}
