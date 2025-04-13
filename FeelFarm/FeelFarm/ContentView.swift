//
//  ContentView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundStyle(.secondaryLight)
        }
        .padding()
        .task {
            // 폰트 체크 하기
            UIFont.familyNames.sorted().forEach { familyName in
                print("*** \(familyName) ***")
                UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                    print("\(fontName)")
                }
                print("---------------------")
            }
        }
    }
}

#Preview {
    ContentView()
}
