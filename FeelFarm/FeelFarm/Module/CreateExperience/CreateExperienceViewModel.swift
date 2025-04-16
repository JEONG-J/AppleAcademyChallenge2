//
//  CreaetExperinceViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation

@Observable
class CreateExperienceViewModel {
    var textEdit: String = ""
    var selectedEmotion: EmotionType?
    
    let fieldType: FieldType
    let container: DIContainer
    
    init(fieldType: FieldType, container: DIContainer) {
        self.fieldType = fieldType
        self.container = container
    }
}
