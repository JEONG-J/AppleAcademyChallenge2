//
//  NoEmotionChartData.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import SwiftUI

struct NoEmotionChartData: View {
    
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.91, green: 0.96, blue: 0.98), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.76, green: 0.89, blue: 0.95), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            ).opacity(0.90)
            
            VStack(spacing: 9,content: {
                Group {
                    Text("등록된 감정이 없습니다!")
                        .font(.T22bold)
                    
                    
                    Text("나의 감정 그래프를 보고 싶다면?")
                        .font(.T14bold)
                    
                    Button(action: {
                        container.navigationRouter.push(to: .createEmotionView)
                    }, label: {
                        Text("감정 등록하러 가기 👉")
                            .font(.T12medium)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 32)
                            .background {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .shadow04()
                            }
                    })
                }
                .foregroundStyle(.gray07)
            })
            .frame(width: 208, height: 98)
        }
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    NoEmotionChartData()
        .environmentObject(DIContainer())
}
