//
//  FieldType.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import SwiftUI

enum FieldType: String ,CaseIterable {
    case domain = "도메인"
    case tech =  "테크"
    case design = "디자인"
    
    var coverImage: Image {
        switch self {
        case .domain:
            return Image(.domainCover)
        case .tech:
            return Image(.techCover)
        case .design:
            return Image(.designCover)
        }
    }
}
