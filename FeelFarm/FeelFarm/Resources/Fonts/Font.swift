//
//  Font.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Medium"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    enum Mitr {
        case bold
        
        var value: String {
            switch self {
            case .bold:
                return "Mitr-Bold"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func mitr(type: Mitr, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    //MARK: - HeadLine
    
    static var HeadLineLogo: Font {
        return .mitr(type: .bold, size: 40)
    }
    
    static var HeadLine01: Font {
        return .pretendard(type: .bold, size: 40)
    }
    
    static var HeadLine02: Font {
        return .pretendard(type: .bold, size: 32)
    }
    
    //MARK: - T24
    
    static var T24bold: Font {
        return .pretendard(type: .bold, size: 24)
    }
    
    static var T24medium: Font {
        return .pretendard(type: .medium, size: 24)
    }
    
    static var T24Light: Font {
        return .pretendard(type: .light, size: 24)
    }
    
    //MARK: - T22
    
    static var T22bold: Font {
        return .pretendard(type: .bold, size: 22)
    }
    
    static var T22medium: Font {
        return .pretendard(type: .medium, size: 22)
    }
    
    static var T22Light: Font {
        return .pretendard(type: .light, size: 22)
    }
    
    //MARK: - T20
    
    static var T20bold: Font {
        return .pretendard(type: .bold, size: 20)
    }
    
    static var T20Semibold: Font {
        return .pretendard(type: .semibold, size: 20)
    }
    
    static var T20medium: Font {
        return .pretendard(type: .medium, size: 20)
    }
    
    static var T20Light: Font {
        return .pretendard(type: .light, size: 20)
    }
    //MARK: - T18
    
    static var T18bold: Font {
        return .pretendard(type: .bold, size: 18)
    }
    
    static var T18Semibold: Font {
        return .pretendard(type: .semibold, size: 18)
    }
    
    static var T18medium: Font {
        return .pretendard(type: .medium, size: 18)
    }
    
    static var T18Light: Font {
        return .pretendard(type: .light, size: 18)
    }
    //MARK: - T16
    
    static var T16bold: Font {
        return .pretendard(type: .bold, size: 16)
    }
    
    static var T16Semibold: Font {
        return .pretendard(type: .semibold, size: 16)
    }
    
    static var T16medium: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var T16Light: Font {
        return .pretendard(type: .light, size: 16)
    }
    
    //MARK: - T14
    
    static var T14bold: Font {
        return .pretendard(type: .bold, size: 14)
    }
    
    static var T14Semibold: Font {
        return .pretendard(type: .semibold, size: 14)
    }
    
    static var T14medium: Font {
        return .pretendard(type: .medium, size: 14)
    }
    
    static var T14Light: Font {
        return .pretendard(type: .light, size: 14)
    }
    
    //MARK: - T13
    
    static var T13bold: Font {
        return .pretendard(type: .bold, size: 13)
    }
    
    static var T13medium: Font {
        return .pretendard(type: .medium, size: 13)
    }
    
    static var T13Light: Font {
        return .pretendard(type: .light, size: 13)
    }
    
    static var T13Regular: Font {
        return .pretendard(type: .regular, size: 13)
    }
    
    //MARK: - T12
    
    static var T12bold: Font {
        return .pretendard(type: .bold, size: 12)
    }
    
    static var T12medium: Font {
        return .pretendard(type: .medium, size: 12)
    }
    
    static var T12Light: Font {
        return .pretendard(type: .light, size: 12)
    }
    
    //MARK: - T11
    
    static var T11bold: Font {
        return .pretendard(type: .bold, size: 11)
    }
    
    static var T11medium: Font {
        return .pretendard(type: .medium, size: 11)
    }
    
    static var T11Light: Font {
        return .pretendard(type: .light, size: 11)
    }
}
