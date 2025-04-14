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
}
