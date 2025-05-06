//
//  CustomProgressView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/20/25.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ProgressView()
                .controlSize(.regular)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    CustomProgressView()
}
