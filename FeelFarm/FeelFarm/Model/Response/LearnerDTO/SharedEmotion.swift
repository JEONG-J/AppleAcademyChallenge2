//
//  LearnerResponse.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/15/25.
//

import Foundation
import FirebaseFirestore

struct SharedEmotion: Identifiable, EmotionProtocol, Equatable {
    var id: String
    var content: String
    var emotion: EmotionType
    var feedback: String
    var field: FieldType
    var nickname: String
    var uid: String
    var date: Date
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
