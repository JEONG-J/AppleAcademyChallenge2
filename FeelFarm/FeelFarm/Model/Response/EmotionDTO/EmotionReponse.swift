//
//  EmotionRequest.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import FirebaseFirestore

/// 유저 개인 데이터 Response
struct EmotionResponse: Identifiable, EmotionProtocol, Hashable {
    var id: String
    var emotion: EmotionType
    var content: String
    var feedback: String
    var date: Date
    var field: FieldType
    var sharePostId: String
}

extension EmotionResponse {
    init?(document: DocumentSnapshot) {
        guard let data = document.data(),
              let emotionRaw = data["emotion"] as? String,
              let emotion = EmotionType(rawValue: emotionRaw),
              let content = data["content"] as? String,
              let feedback = data["feedback"] as? String,
              let timestamp = data["createdAt"] as? Timestamp,
              let fieldRaw = data["field"] as? String,
              let field = FieldType(rawValue: fieldRaw),
              let sharePostId = data["sharePostId"] as? String else {
            return nil
        }
        
        self.id = document.documentID
        self.emotion = emotion
        self.content = content
        self.feedback = feedback
        self.date = timestamp.dateValue()
        self.field = field
        self.sharePostId = sharePostId
    }
}
