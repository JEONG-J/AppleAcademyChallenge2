//
//  CreaetExperinceViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class CreateExperienceViewModel {
    var textEdit: String = ""
    var selectedEmotion: EmotionType?
    var feedback: String = "하하"
    
    var isLoading: Bool = false
    var isSuccess: Bool = false
    
    let fieldType: FieldType
    let container: DIContainer
    
    init(fieldType: FieldType, container: DIContainer) {
        self.fieldType = fieldType
        self.container = container
    }
    
    func saveEmotionExperience() {
        guard let selectedEmotion = selectedEmotion else {
            print("감정 선택 안됨")
            return
        }
        
        guard !textEdit.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("감정 경험 작성 안됨")
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("감정 경험 생성 유저 정보 필요")
            return
        }
        
        let db = Firestore.firestore()
        let batch = db.batch()
        
        let sharedDocRef = db.collection("shared_experience").document()
        let sharedDocId = sharedDocRef.documentID
        
        // 4. 개인 감정 문서 참조 생성
        let personalDocRef = db.collection("users").document(uid).collection("emotions").document()
        
        // 5. 개인 감정 데이터 생성
        let emotionData: [String: Any] = [
            "content": self.textEdit,
            "emotion": selectedEmotion.rawValue,
            "field": self.fieldType.rawValue,
            "createdAt": FieldValue.serverTimestamp(),
            "feedback": feedback,
            "sharePostId": sharedDocId
        ]
        
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                self.isLoading = false
                print("경험 생성 error: \(error)")
                return
            }
            
            let userData = snapshot?.data() ?? [:]
            let nickname = userData["nickname"] as? String ?? "익명"
            
            let sharedData: [String: Any] = [
                "content": self.textEdit,
                "emotion": selectedEmotion.rawValue,
                "field": self.fieldType.rawValue,
                "createAt": FieldValue.serverTimestamp(),
                "feedback": feedback,
                "nickname": nickname,
                "uid": uid
            ]
            
            batch.setData(emotionData, forDocument: personalDocRef)
            batch.setData(sharedData, forDocument: sharedDocRef)
            
            batch.commit { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    self.isLoading = false
                    print("경험 생성 error: \(error)")
                    return
                }
                
                self.updateEmotionStats(emotion: selectedEmotion)
                
                self.isLoading = false
                self.isSuccess = true
                container.navigationRouter.pop()
                self.resetForm()
            }
        }
    }
    
    private func updateEmotionStats(emotion: EmotionType) {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(uid)
            
            db.runTransaction({ (transaction, errorPointer) -> Any? in
                let userDocument: DocumentSnapshot
                do {
                    try userDocument = transaction.getDocument(userRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                
                // 기존 통계 데이터 가져오기
                var emotionStats: [String: Int] = [:]
                if let existingStats = userDocument.data()?["emotionStats"] as? [String: Int] {
                    emotionStats = existingStats
                }
                
                // 해당 감정 카운트 증가
                let emotionKey = emotion.rawValue
                let currentCount = emotionStats[emotionKey] ?? 0
                emotionStats[emotionKey] = currentCount + 1
                
                // 업데이트된 통계 저장
                transaction.updateData(["emotionStats": emotionStats], forDocument: userRef)
                return nil
            }) { (_, error) in
                if let error = error {
                    print("감정 통계 업데이트 실패: \(error.localizedDescription)")
                }
            }
        }
    
    func resetForm() {
        textEdit = ""
        selectedEmotion = nil
    }
}
