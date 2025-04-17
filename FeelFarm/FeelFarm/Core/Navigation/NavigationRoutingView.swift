//
//  NavigationRoutingView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import SwiftUI

struct NavigationRoutingView: View {
    
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .createExperience(let field):
            CreateExperience(fieldType: field, container: container)
        case .myToDetailExpereince(let data):
            DetailExperienceView(emotionData: data, container: container)
        case .shareToDetailExperience(let data):
            DetailExperienceView(emotionData: data, container: container)
        }
    }
}
