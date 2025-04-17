//
//  FieldType.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import SwiftUI

enum FieldType: String ,CaseIterable, SegmentType, Equatable {
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
    
    var title: String {
        switch self {
        case .domain:
            return "도메인"
        case .tech:
            return "테크"
        case .design:
            return "디자인"
        }
    }
    
    var createText: String {
        switch self {
        case .domain:
            return "Domain 작성하기"
        case .tech:
            return "Tech 작성하기"
        case .design:
            return "Design 작성하기"
        }
    }
    
    var createIcon: Image {
        switch self {
        case .domain:
            return .init(.domainDrag)
        case .tech:
            return .init(.techDrag)
        case .design:
            return .init(.designDrag)
        }
    }
}
