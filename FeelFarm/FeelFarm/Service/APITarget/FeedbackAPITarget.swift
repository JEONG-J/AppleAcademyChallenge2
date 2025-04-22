//
//  FeedbackAPITarget.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/22/25.
//

import Foundation
import Moya

enum FeedbackAPITarget {
    case getAI(model: AIModel)
}

extension FeedbackAPITarget: TargetType {
    var baseURL: URL {
        let url = URL(string: Config.AppURL)!
        return url
    }
    
    var path: String {
        switch self {
        case .getAI:
            return "/api/generate"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAI:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getAI(let model):
            return .requestJSONEncodable(model)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
}
