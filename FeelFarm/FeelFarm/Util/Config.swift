//
//  Config.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

enum Config {
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist cannot be fount")
        }
        return dict
    }()
    
    static let ServiceKey: String = {
        guard let serviceKey = Config.infoDictionary["ServiceKey"] as? String else {
            fatalError("ServiceKey")
        }
        return serviceKey
    }()
    
    static let AppURL: String = {
        guard let aiURL = Config.infoDictionary["AIURL"] as? String else {
            fatalError("AIError")
        }
        return aiURL
    }()
}
