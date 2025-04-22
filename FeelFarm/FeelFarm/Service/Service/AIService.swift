//
//  AIService.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

class AIService: AIServiceProtocol {
    
    private let provider: MoyaProvider<FeedbackAPITarget>
    
    init(provider: MoyaProvider<FeedbackAPITarget> = MoyaProvider<FeedbackAPITarget>()) {
        self.provider = provider
    }
    
    func getAIData(model: AIModel) -> AnyPublisher<AIResponse, Moya.MoyaError> {
        return provider.requestPublisher(.getAI(model: model))
            .handleEvents(receiveOutput: { response in
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("Raw JSON Response: \n\(jsonString)")
                }
            })
            .map(\.data)
            .decode(type: AIResponse.self, decoder: JSONDecoder())
            .mapError { error in
                return error as? MoyaError ?? MoyaError.underlying(error, nil)
            }
            .eraseToAnyPublisher()
    }
}
