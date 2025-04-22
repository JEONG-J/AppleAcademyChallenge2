//
//  DetailExperienceViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

@Observable
class DetailExperienceViewModel {
    var experienceData: any EmotionProtocol
    var container: DIContainer
    var modifyText: String
    private let db = Firestore.firestore()
    
    var isLoading: Bool = true
    var isCurrentUserData: Bool = false
    
    private var cancellalbes = Set<AnyCancellable>()
    
    init(experienceData: any EmotionProtocol, container: DIContainer) {
        self.experienceData = experienceData
        self.container = container
        self.modifyText = experienceData.content
        checkOwnership()
    }
    
    func getAIResponse() {
        
        isLoading = true
        
        container.userCaseProvider.aiUsecase.getAI(model: makeAIModel())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("getAIModel Completed")
                case .failure(let failure):
                    print("getAIModel Error: \(failure  )")
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] responseData in
                self?.experienceData.feedback = responseData.response
                
                self?.updateEmotion()
                self?.isLoading = false
            })
            .store(in: &cancellalbes)
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
    
    func deleteEmotion() {
        guard isCurrentUserData else { return }
        
        if let sharedEmotion = experienceData as? SharedEmotion {
            let db = Firestore.firestore()
            
            // 1. 공유 문서 삭제
            db.collection("shared_experience")
                .document(sharedEmotion.id)
                .delete()
            
            // 2. 연결된 개인 문서 삭제
            db.collection("users")
                .document(sharedEmotion.uid)
                .collection("emotions")
                .whereField("sharePostId", isEqualTo: sharedEmotion.id)
                .getDocuments { snapshot, error in
                    guard let documents = snapshot?.documents else { return }
                    for document in documents {
                        document.reference.delete()
                    }
                }
            
            // 3. 화면 pop
            container.navigationRouter.pop()
            
        } else if let emotionResponse = experienceData as? EmotionResponse {
            print(emotionResponse.id)
            
            guard let uid = Auth.auth().currentUser?.uid else {
                print("❌ 유저 UID 없음")
                return
            }
            
            let group = DispatchGroup()
            
            group.enter()
            db.collection("users")
                .document(uid)
                .collection("emotions")
                .document(emotionResponse.id)
                .delete { error in
                    if let error = error {
                        print("개인 감정 삭제 실패: \(error.localizedDescription)")
                    } else {
                        print("개인 감정 삭제 성공")
                    }
                    group.leave()
                }
            
            // 공유 감정 삭제
            group.enter()
            db.collection("shared_experience")
                .document(emotionResponse.sharePostId)
                .delete { error in
                    if let error = error {
                        print("❌ 공유 감정 삭제 실패: \(error.localizedDescription)")
                    } else {
                        print("공유 감정 삭제 성공")
                    }
                    group.leave()
                }
            
            group.notify(queue: .main) {
                self.container.navigationRouter.pop()
            }
        }
    }
    
    func updateEmotion() {
        guard isCurrentUserData else { return }
        
        print("업데이트 진행")
        
        let db = Firestore.firestore()
        
        // 공유 경험 수정
        if let sharedEmotion = experienceData as? SharedEmotion {
            // 1. 공유 문서 업데이트
            db.collection("shared_experience")
                .document(sharedEmotion.id)
                .updateData([
                    "content": self.modifyText,
                    "feedback": self.experienceData.feedback
                ])
            
            // 2. 연결된 개인 문서도 업데이트
            db.collection("users")
                .document(sharedEmotion.uid)
                .collection("emotions")
                .whereField("sharePostId", isEqualTo: sharedEmotion.id)
                .getDocuments { snapshot, error in
                    guard let documents = snapshot?.documents else { return }
                    
                    for doc in documents {
                        doc.reference.updateData([
                            "content": self.modifyText,
                            "feedback": self.experienceData.feedback
                        ])
                    }
                }
        }
        
        // 개인 경험 수정
        else if let emotionResponse = experienceData as? EmotionResponse {
            
            guard let uid = Auth.auth().currentUser?.uid else {
                print("유저 UID 없음")
                return
            }
            // 1. 개인 문서 업데이트 (컬렉션 경로 수정!)
            db.collection("users")
                .document(uid)
                .collection("emotions")
                .document(emotionResponse.id)
                .updateData([
                    "content": self.modifyText,
                    "feedback": self.experienceData.feedback
                ]) { error in
                    if let error = error {
                        print("개인 감정 수정 실패: \(error.localizedDescription)")
                    } else {
                        print("개인 감정 수정 성공")
                    }
                }
            
            // 2. 연결된 공유 문서도 업데이트
            db.collection("shared_experience")
                .document(emotionResponse.sharePostId)
                .updateData([
                    "content": self.modifyText,
                    "feedback": self.experienceData.feedback
                ]) { error in
                    if let error = error {
                        print("공유 감정 수정 실패: \(error.localizedDescription)")
                    } else {
                        print("공유 감정 수정 성공")
                    }
                }
        }
    }
    
    
    private func makeAIModel() -> AIModel {
        return .init(model: "hf.co/MLP-KTLim/llama-3-Korean-Bllossom-8B-gguf-Q4_K_M", system: "당신은 달콤하고 순수하며 사랑스러운 작은 친구입니다. “괜찮아~”, “내가 여기 있어!”, “수고했어 💛”, “안아 안아~”, “슬퍼하지 마~” 등과 같은 친근한 표현을 사용하세요. 직접적인 격려의 메시지 하나만 남겨주세요.", prompt: "현재 나의 기분은 \(experienceData.emotion.emotionKorean)입니다. \(modifyText)", stream: false)
    }
}
