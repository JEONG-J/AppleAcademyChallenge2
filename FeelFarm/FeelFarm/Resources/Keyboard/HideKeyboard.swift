//
//  HideKeyboard.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/17/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            guard let window = windowScene.windows.first else { return }
            let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
            tapRecognizer.cancelsTouchesInView = false
            tapRecognizer.delegate = self
            window.addGestureRecognizer(tapRecognizer)
        }
    }
}

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
