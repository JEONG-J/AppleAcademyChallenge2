//
//  EmotionChardView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import SwiftUI
import Charts

struct EmotionChartView: View {
    
    @Bindable var viewModel: HomeViewModel
    @EnvironmentObject var container: DIContainer
    @AppStorage("userNickname") private var nickname: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(Color.white)
                .shadow02()
            
            VStack(spacing: 25, content: {
                chartTitle
                chartPieGraph
                chartStickGraph
            })
            
            if viewModel.isAllZero {
                NoEmotionChartData()
                    .environmentObject(container)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 506)
    }
    
    private var chartTitle: some View {
        VStack(spacing: 4, content: {
            Text(Date().formatted(.dateTime
                .year().locale(Locale(identifier: "ko_KR"))
                .month()
                .day()
            ))
            .font(.T12medium)
            .foregroundStyle(Color.gray05)
            
            Text("\(nickname ?? "감자") 감정 그래프 📊")
                .font(.T18medium)
                .foregroundStyle(Color.gray06)
        })
    }
    
    private var chartPieGraph: some View {
        Chart(viewModel.emotions) { emotion in
            SectorMark(
                angle: .value("Value", emotion.value),
                innerRadius: .ratio(0.6),
                angularInset: 1
            )
            .clipShape(.rect(cornerRadius: 3))
            .foregroundStyle(emotion.type.emotionColor)
        }
        .chartBackground { chartProxy in
            GeometryReader { geo in
                if let anchor = chartProxy.plotFrame {
                    let frame = geo[anchor]
                    VStack {
                        Text("당신의 감정")
                            .font(.T14bold)
                            .foregroundStyle(Color.gray05)
                        viewModel.domainationEmotion.type.emotionIcon
                            .resizable()
                            .frame(maxWidth: 59, maxHeight: 33)
                            .aspectRatio(contentMode: .fit)
                    }
                    .position(x: frame.midX,  y: frame.midY)
                }
            }
        }
        .frame(width: 200, height: 200)
    }
    
    private var chartStickGraph: some View {
        VStack(spacing: 12, content: {
            ForEach(viewModel.emotions, id: \.id) { emotion in
                HStack(spacing: 5, content: {
                    Text(emotion.type.emotionKorean)
                        .font(.T14bold)
                        .foregroundStyle(.gray04)
                    
                    ProgressView(value: Double(emotion.value), total: 100)
                        .progressViewStyle(.linear)
                        .tint(emotion.type.emotionColor)
                        .frame(maxWidth: 200, maxHeight: 15)
                        .scaleEffect(x: 1, y: 4.0, anchor: .center)
                        .clipShape(.rect(cornerRadius: 15))
                    
                    Text(String(emotion.value))
                        .font(.T14bold)
                        .foregroundStyle(Color.gray04)
                })
            }
        })
    }
}

#Preview {
    EmotionChartView(viewModel: .init())
        .environmentObject(DIContainer())
}
