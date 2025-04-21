//
//  HomeViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable
class HomeViewModel {
    var emotionType: EmotionType = .happy
    
    var isEmotionPickerViewAnimation: Bool = false
    var isEmotionPickerPresented: Bool = false
    var isLoading: Bool = true
    
    var emotionReponse: EmotionResponse? = .init(id: "0", emotion: .happy, content: "오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!오늘 SwiftUI의 수정자를 공부했어요!으아아앙으아아아아ㅡ앙아ㅏ아으아아아아ㅡ아아아으아아아으아아앙", feedback: "으아아", date: .now, field: .design, sharePostId: "11")
    
    
    var sharedEmotion: [SharedEmotion]?
    
    var emotionStats: EmotionStats?
    var emotions: [EmotionChartData] {
        
        guard let stats = emotionStats else {
            return dummyChartData
        }
        
        let chartData = stats.values.map {
            EmotionChartData(type: $0.key, value: $0.value)
        }
        
        let isAllZero = chartData.allSatisfy { $0.value == 0 }
        
        return isAllZero ? dummyChartData : chartData.filter { $0.value >= 0 }
    }
    
    private var dummyChartData: [EmotionChartData] {
        EmotionType.allCases.map { EmotionChartData(type: $0, value: 99) }
    }
    
    var domainationEmotion: EmotionChartData {
        emotions.max(by: {$0.value < $1.value}) ?? EmotionChartData(type: .happy, value: 0)
    }
    var isAllZero: Bool {
        guard let stats = emotionStats else {
            return true
        }
        
        let allValues = stats.values.map { $0.value }
        return allValues.allSatisfy { $0 == 0 }
    }
    
    /// 홈 탭 최상단 감정 경험 get
    /// - Parameter type: 감정 타입
    func getLatestEmotion(of type: EmotionType, completion: @escaping () -> Void = {}) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("최근 이모션 로그인 유저 없음")
            return
        }
        
        let db = Firestore.firestore()
        
        // 사용자 문서 확인 단계는 실제로 필요하지 않습니다.
        // Firestore는 컬렉션이 없어도 쿼리 시 오류를 발생시키지 않습니다.
        db.collection("users")
            .document(uid)
            .collection("emotions")
            .whereField("emotion", isEqualTo: type.rawValue)
            .order(by: "createdAt", descending: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    if error.localizedDescription.contains("requires an index") {
                        print("인덱스가 필요합니다. Firebase 콘솔에서 인덱스를 생성해주세요.")
                    } else {
                        print("'\(type.rawValue)' 감정 불러오기 실패: \(error.localizedDescription)")
                    }
                    self.emotionReponse = nil
                    completion()
                    return
                }
                
                // 컬렉션이 없거나 문서가 없는 경우
                if snapshot?.documents.isEmpty ?? true {
                    print("'\(type.rawValue)' 감정 기록이 없습니다.")
                    self.emotionReponse = nil
                    completion()
                    return
                }
                
                guard let document = snapshot?.documents.first,
                      let emotion = EmotionResponse(document: document) else {
                    print("감정 데이터 파싱 실패")
                    self.emotionReponse = nil
                    completion()
                    return
                }
                
                self.emotionReponse = emotion
                self.emotionType = emotion.emotion
                
                completion()
            }
    }


    
    /// 러너들의 감정 경험 가져오기
    func getSharedEmotoins(completion: @escaping () -> Void = {}) {
        
        Firestore.firestore()
            .collection("shared_experience")
            .order(by: "createAt", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("공유 감정 불로오기 실패: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                let emotions = documents.compactMap { SharedEmotion(document: $0) }
                
                self.sharedEmotion = emotions
                completion()
            }
    }
    
    /// 감정 차트 가져오기
    /// - Parameter completion: 차트 가져온 후 처리
    func getEmotionChart(completion: @escaping () ->  Void = {}) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("이모션차트 로그인 유저 없음")
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print("그래프 기록 없음 \(error.localizedDescription)")
                    return
                }
                
                guard let data = snapshot?.data(),
                      let rawValue = data["emotionStats"] as? [String: Any],
                      let stats = EmotionStats(from: rawValue) else {
                    print("감정 통계 파싱 실패")
                    return
                }
                
                self.emotionStats = stats
                completion()
            }
    }
    
    
    public func loadAllData() {
        
        guard isLoading else { return }
        
        let group = DispatchGroup()
        
        group.enter()
        self.getEmotionChart {
            group.leave()
        }
        
        group.enter()
        self.getLatestEmotion(of: .happy) {
            group.leave()
        }
        
        group.enter()
        self.getSharedEmotoins() {
            group.leave()
        }
        
        group.notify(queue: .main, execute: {
            self.isLoading = false
        })
    }
}
