//
//  NoExpeirenceGuide.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI

struct NoExpeirenceGuide: View {
    var body: some View {
        Text("기록된 경험이 없습니다. 경험을 작성해주세요!")
            .font(.T14medium)
            .foregroundStyle(Color.gray07)
            .frame(maxWidth: .infinity, minHeight: 163)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow03()
            }
    }
}

#Preview {
    NoExpeirenceGuide()
}
