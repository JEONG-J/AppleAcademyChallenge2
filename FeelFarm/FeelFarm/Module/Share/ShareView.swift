//
//  ShareView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct ShareView: View {
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    @Bindable var viewModel: ShareViewModel = .init()
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        ScrollView(.vertical, content: {

            VStack(spacing: 0) {
                headerView()
                
                LazyVStack(alignment: .leading, spacing: 33, pinnedViews: [.sectionHeaders], content: {
                    Section(content: {
                        CustomSegment<FieldType>(selectedSegment: $viewModel.selectedSegment)
                        
                        if !viewModel.sharedData.isEmpty {
                            contents
                        } else {
                            noExperienceData
                        }
                    }, header: {
                        pinnedHeaderView()
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    })
                })
                .safeAreaPadding(.horizontal, 16)
                .contentMargins(.top, 20)
                .padding(.bottom, 100)
            }

        })
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .background(Color.white)
    }
    
    @ViewBuilder
    private var noExperienceData: some View {
        Spacer()
        
        VStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 94, height: 97)
            
            Text("아직 공유된 경험이 없어요! \n누군가의 오늘이 이곳을 채워주길 기다리고 있어요!")
                .font(.T18Semibold)
                .foregroundStyle(Color.gray05)
                .lineLimit(nil)
                .lineSpacing(2.5)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
        }
        Spacer()
    }
    
    private var contents: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 10) {
            ForEach(viewModel.sharedData.indices, id: \.self) { index in
                let shareData = viewModel.sharedData[index]
                
                VStack(spacing: 10) {
                    LearnerExperienceCard(shareData: shareData)
                        .onTapGesture {
                            container.navigationRouter.push(to: .shareToDetailExperience(experienceData: viewModel.sharedData[index]))
                        }
                    
                    if index < viewModel.sharedData.count - 1 {
                        Divider()
                            .foregroundStyle(Color.gray03)
                            .frame(maxWidth: .infinity,  maxHeight: 1)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = size.height + minY
            
            Rectangle()
                .fill(Color.white)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: 10)
    }
    
    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        HStack {
            if headerOffsets.0 < -55 {
                Spacer()
            }
            
            Text("Learners Story")
                .font(headerOffsets.0 < -55 ? .T16Semibold : .T24bold)
                .animation(.easeInOut(duration: 0.4), value: headerOffsets.0)
            
            Spacer()
            
        }
        .frame(height: 90, alignment: .bottomLeading)
        .safeAreaPadding(.bottom, headerOffsets.0 < -55 ? 20 : 0)
        .background(Color.white)
        .shadow04(isActive: headerOffsets.0 < -55)
    }
}

#Preview {
    ShareView()
        .environmentObject(DIContainer())
}
