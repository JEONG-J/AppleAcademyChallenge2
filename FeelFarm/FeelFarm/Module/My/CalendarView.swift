//
//  CalendarView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import SwiftUI

struct CalendarView: View {
    
    var viewModel: CalendarViewModel
    
    @State private var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    @Binding var showAddExperience: Bool
    @EnvironmentObject var container: DIContainer
    @Environment(\.isPresented) var isPresented
    
    init(showAddExperience: Binding<Bool>, container: DIContainer) {
        self._showAddExperience = showAddExperience
        self.viewModel = .init(container: container)
    }
    
    var body: some View {
        ScrollView(.vertical, content: {
            
            VStack(spacing: 0) {
                
                headerView()
                
                LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders] ,content: {
                    Section(content: {
                        CustomCalendar(viewModel: viewModel)
                        
                        SubCalendar(viewModel: viewModel)
                        
                        bottomContents
                    }, header: {
                        pinnedHeaderView()
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    })
                })
                .background(Color.gray01)
                .padding(.bottom, 80)
            }
        })
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .scrollIndicators(.visible)
        .sheet(isPresented: $showAddExperience, content: {
            CreateDragView(showAddExperience: $showAddExperience)
                .presentationDetents([.fraction(0.38)])
                .presentationCornerRadius(30)
        })
        .task {
            print(viewModel.myExperienceData)
            viewModel.fetchEmotionForDate(date: viewModel.selectedDate)
        }
        .onChange(of: viewModel.selectedDate, { _, newValue in
            viewModel.fetchEmotionForDate(date: newValue)
        })
    }
    
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text("\(dayFormatter(date: viewModel.selectedDate)) 일정")
                .font(.T14medium)
                .foregroundStyle(Color.gray06)
            
            if !viewModel.isLoading {
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
            } else {
                HStack {
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                }
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
            .frame(maxWidth: .infinity, minHeight: 85)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.gray01)
            }
    }
    
    private func dayFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = max(0, size.height + minY) 
            
           Rectangle()
            .fill(Color.white)
            .frame(width: size.width, height: height, alignment: .top)
            .offset(y: -minY)
        }
        .frame(height: 20)
    }
    
    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        
        let threshhold = -(getScreenSize().height * 0.05)
        
        ZStack {
            HStack {
                Text("나의 경험")
                    .font(headerOffsets.0 < threshhold ? .T16medium : .T24bold)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: headerOffsets.0 < threshhold ? .center : .bottomLeading)
                    .animation(.easeInOut(duration: 0.3), value: headerOffsets.0)
            }
            .padding(.horizontal, 16)
            
            HStack {
                Spacer()
                
                Button(action: {
                    showAddExperience = true
                }, label: {
                    Image(.plus)
                })
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 10)
        .frame(height: 90, alignment: .bottom)
        .background(Color.white)
        .shadow04(isActive: headerOffsets.0 < threshhold)
    }
}

#Preview {
    CalendarView(showAddExperience: .constant(false), container: DIContainer())
}
