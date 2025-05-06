//
//  CustomSegment.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct CustomSegment<T: SegmentType & CaseIterable>: View {
    
    @State private var segmentWidth: [T: CGFloat] = [:]
    @Binding var selectedSegment: T
    @Namespace var name
    
    var body: some View {
        HStack(spacing: 16, content: {
            ForEach(Array(T.allCases), id: \.self) { segment in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        selectedSegment = segment
                    }
                }, label: {
                    makeSegmentButton(segment: segment)
                })
            }
        })
        .background(Color.white)
    }
    
    private func makeSegmentButton(segment: T) -> some View {
        VStack(alignment: .center, spacing: 0, content: {
            Text(segment.title)
                .font(.T24bold)
                .foregroundStyle(selectedSegment == segment ? Color.black : Color.gray03)
                .background {
                    GeometryReader { geo in
                        Color.clear
                            .task {
                                segmentWidth[segment] = geo.size.width
                            }
                    }
                }
            
            Capsule()
                .fill(Color.clear)
                .frame(width: segmentWidth[segment] ?? 0, height: 4)
            
            if selectedSegment == segment {
                ZStack {
                    Capsule()
                        .fill(Color.feelFarmOrange)
                        .frame(width: segmentWidth[segment] ?? 0, height: 4)
                        .matchedGeometryEffect(id: "Tab", in: name)
                }
            }
        })
    }
}
