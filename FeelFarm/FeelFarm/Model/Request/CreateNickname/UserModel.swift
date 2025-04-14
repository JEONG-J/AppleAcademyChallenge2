//
//  UserModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import FirebaseFirestore

struct UserModel {
    let nickname: String
    let joinedAt: Date
    let profileImageName: String
    let emotionStats: [String: Int]
    
    init(nickname: String, profileImageName: String) {
        self.nickname = nickname
        self.joinedAt = Date()
        self.profileImageName = profileImageName
        self.emotionStats = [
            "angry": 0,
            "happy": 0,
            "inspiration": 0,
            "sad": 0,
            "toudched": 0
        ]
    }
    
    var toDictionary: [String: Any] {
        return [
            "nickname": nickname,
            "joinedAt": Timestamp(date: joinedAt),
            "profileImageName": profileImageName,
            "emotionStats": emotionStats
        ]
    }
}

