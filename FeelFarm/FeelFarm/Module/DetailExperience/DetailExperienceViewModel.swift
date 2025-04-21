//
//  DetailExperienceViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable
class DetailExperienceViewModel {
    var experienceData: any EmotionProtocol
    var container: DIContainer
    private let db = Firestore.firestore()
    
    var isLoading: Bool = true
    var isCurrentUserData: Bool = false
    
    init(experienceData: any EmotionProtocol, container: DIContainer) {
        self.experienceData = experienceData
        self.container = container
        checkOwnership()
    }
    
    func checkOwnership() {
        guard let currentUser = Auth.auth().currentUser else {
            isCurrentUserData = false
            isLoading = false
            return
        }
        
        let currentUserId = currentUser.uid
        
        if let sharedEmotion = experienceData as? SharedEmotion {
            isCurrentUserData = sharedEmotion.uid == currentUserId
        } else if let _ = experienceData as? EmotionResponse {
            isCurrentUserData = true
        }
        
        isLoading = false
    }
    
    func deleteEmotion() async throws {
        guard isCurrentUserData else { return }
        
        if let sharedEmotion = experienceData as? SharedEmotion {
            try await db.collection("emotions").document(sharedEmotion.id).delete()
            try await db.collection("shared_experience").document(sharedEmotion.id).delete()
            
        } else if let emotinoResponse = experienceData as? EmotionResponse {
            try await db.collection("emotions").document(emotinoResponse.id).delete()
        }
        
        container.navigationRouter.pop()
    }
    
    func updateEmotion() {
        guard isCurrentUserData else { return }
        
        if let sharedEmotion = experienceData as? SharedEmotion {
            db.collection("shared_experience").document(sharedEmotion.id).updateData([
                "content": self.experienceData.content,
                "feedback": self.experienceData.feedback
            ])
        } else if let emotionReponse = experienceData as? EmotionResponse {
            db.collection("emotions").document(emotionReponse.id).updateData([
                "content": self.experienceData.content,
                "feedback": self.experienceData.feedback
            ])
        }
    }
}
