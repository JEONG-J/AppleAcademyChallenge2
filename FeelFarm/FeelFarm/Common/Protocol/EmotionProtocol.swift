//
//  EmotionProtocol.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/17/25.
//

import Foundation

protocol EmotionProtocol: Equatable {
    var id: String { get set}
    var content: String { get set}
    var emotion: EmotionType { get set}
    var feedback: String { get set}
    var field: FieldType { get set}
    var date: Date { get set}
}
