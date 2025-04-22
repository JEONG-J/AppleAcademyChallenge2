//
//  UseCaseProvider.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation

protocol UseCaseProtocl {
    var holidayUsecase: HolidayUsecase { get set }
    var aiUsecase: AIUsecase { get set }
}

class UseCaseProvider: UseCaseProtocl {
    var holidayUsecase: HolidayUsecase
    var aiUsecase: AIUsecase
    
    init() {
        self.holidayUsecase = .init()
        self.aiUsecase = .init()
    }
}
