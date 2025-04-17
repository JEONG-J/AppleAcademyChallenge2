//
//  CalendarView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct CalendarView: View {
    
    var viewModel: CalendarViewModel
    @State var showAddExperience: Bool = false
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    var body: some View {
        ScrollView(.vertical, content: {
            VStack(spacing: 12, content: {
                TopStatus(text: "나의 경험", action: {
                    showAddExperience = true
                })
                
                CustomCalendar(viewModel: viewModel)
                
                SubCalendar(viewModel: viewModel)
                
                bottomContents
            })
            .background(Color.gray01)
        })
        .scrollIndicators(.visible)
        .contentMargins(.bottom, 20)
        .sheet(isPresented: $showAddExperience, content: {
            CreateDragView()
                .presentationDetents([.fraction(0.4)])
                .presentationCornerRadius(30)
        })
    }
    
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text("\(dayFormatter) 일정")
                .font(.T14medium)
                .foregroundStyle(Color.gray06)
            
            if !viewModel.myExperienceData.isEmpty {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 16, content: {
                    ForEach(viewModel.myExperienceData, id: \.id) { emotionReponse in
                        MyExperienceCard(emotionReponse: emotionReponse)
                            .onTapGesture {
                                container.navigationRouter.push(to: .myToDetailExpereince(experienceData: emotionReponse))
                            }
                    }
                })
            } else {
                noneRecod
            }
            
            Spacer()
        })
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(Color.white)
    }
    
    private var noneRecod: some View {
        Text("생선된 경험이 없습니다. 경험을 추가해보세요")
            .font(.T14Semibold)
            .foregroundStyle(Color.gray04)
            .frame(maxWidth: .infinity, maxHeight: 85)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.gray01)
            }
    }
    
    private let dayFormatter: String = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"

        let dateString = formatter.string(from: Date())
        return dateString
    }()
}

#Preview {
    CalendarView(container: DIContainer())
        .environmentObject(DIContainer())
}
