//
//  DetailExperienceViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation

@Observable
class DetailExperienceViewModel {
    var experienceData: any EmotionProtocol
    var container: DIContainer
    
    init(experienceData: any EmotionProtocol, container: DIContainer) {
        self.experienceData = experienceData
        self.container = container
    }
}
