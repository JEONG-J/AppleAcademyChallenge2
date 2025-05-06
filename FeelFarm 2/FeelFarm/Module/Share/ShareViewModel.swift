//
//  ShareViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/16/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class ShareViewModel {
    var selectedSegment: FieldType = .domain
    var sharedData: [SharedEmotion] = []
    var isLoading: Bool = false
    
    func getEmotionsByField(field: String) {
        let db = Firestore.firestore()
        
        // isLoading 상태 설정
        isLoading = true
        
        db.collection("shared_experience")
            .whereField("field", isEqualTo: field)
            .order(by: "createAt", descending: true)
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                // 로딩 완료
                self.isLoading = false
                
                if let error = error {
                    print("분야별 감정 데이터 가져오기 실패: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("해당 분야의 데이터가 없습니다")
                    return
                }
                
                // 데이터 파싱 및 저장
                let emotions = documents.compactMap { SharedEmotion(document: $0) }
                self.sharedData = emotions
            }
    }
}
