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
    
    var emotionReponse: EmotionResponse?
    var sharedEmotion: [SharedEmotion]?
    
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
}
