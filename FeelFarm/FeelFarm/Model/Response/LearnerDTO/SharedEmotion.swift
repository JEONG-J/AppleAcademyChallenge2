//
//  LearnerResponse.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation
import FirebaseFirestore

struct SharedEmotion: Identifiable {
    let id: String
    let content: String
    let emotion: EmotionType
    let feedback: String
    let field: FieldType
    let nickname: String
    let uid: String
    let date: Date
}

extension SharedEmotion {
    init?(document: DocumentSnapshot) {
        guard let data = document.data(),
              let content = data["content"] as? String,
              let emotionRaw = data["emotion"] as? String,
              let emotion = EmotionType(rawValue: emotionRaw),
              let feedback = data["feedback"] as? String,
              let fieldRaw = data["field"] as? String,
              let field = FieldType(rawValue: fieldRaw),
              let nickname = data["nickname"] as? String,
              let uid = data["uid"] as? String,
              let timestamp = data["createAt"] as? Timestamp else {
            return nil
        }

        self.id = document.documentID
        self.content = content
        self.emotion = emotion
        self.feedback = feedback
        self.field = field
        self.nickname = nickname
        self.uid = uid
        self.date = timestamp.dateValue()
    }
}
