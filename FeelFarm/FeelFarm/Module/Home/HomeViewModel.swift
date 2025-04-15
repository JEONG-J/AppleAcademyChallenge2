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
    
    var emotionReponse: EmotionResponse? = .init(id: "0", emotion: .happy, content: "오늘 SwiftUI의 수정자를 공부했어요!", feedback: "으아아", date: .now, field: .design, sharePostId: "11")
    var sharedEmotion: [SharedEmotion]? = [
        .init(id: "1", content: "우선순위가 계속 바뀌는 바람에..", emotion: .sad, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now),
        .init(id: "2", content: "피그마 사용법을 공부했는데 참고..", emotion: .touched, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now),
        .init(id: "3", content: "네트워크 레이어를 리팩토링면서..", emotion: .inspiration, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now),
        .init(id: "4", content: "블라블블라블블라블블라블블라..", emotion: .happy, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now),
        .init(id: "5", content: "네트워크 레이어를 리팩토링면서..", emotion: .inspiration, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now),
        .init(id: "6", content: "네트워크 레이어를 리팩토링면서..", emotion: .inspiration, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now),
        .init(id: "7", content: "네트워크 레이어를 리팩토링면서..", emotion: .inspiration, feedback: "정말 잘했어요!", field: .design, nickname: "제옹", uid: "123", date: .now)
    ]
    
    var emotionStats: EmotionStats?
    var emotions: [EmotionChartData] {
        
        guard let stats = emotionStats else {
            return dummyChartData
        }

        let chartData = stats.values.map {
            EmotionChartData(type: $0.key, value: $0.value)
        }

        let isAllZero = chartData.allSatisfy { $0.value == 0 }

        return isAllZero ? dummyChartData : chartData.filter { $0.value > 0 }
    }

    private var dummyChartData: [EmotionChartData] {
        EmotionType.allCases.map { EmotionChartData(type: $0, value: 99) }
    }
    
    var domainationEmotion: EmotionChartData {
        emotions.max(by: {$0.value < $1.value}) ?? EmotionChartData(type: .happy, value: 0)
    }
    var isAllZero: Bool {
        emotions.allSatisfy { $0.value == 0 }
    }
    
    func getLatestEmotion(of type: EmotionType) {
        print("감정 경험 get")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("emotions")
            .whereField("emotion", isEqualTo: type.rawValue)
            .order(by: "createdAt", descending: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("'\(type.rawValue)' 감정 불러오기 실패: \(error.localizedDescription)")
                    return
                }
                
                guard let document = snapshot?.documents.first,
                      let emotion = EmotionResponse(document: document) else {
                    return
                }
                
                self.emotionReponse = emotion
                
            }
    }
    
    func getSharedEmotoins() {
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
            }
    }
    
    func getEmotionChart(completion: @escaping () ->  Void = {}) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("로그인 유저 없음")
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
}
