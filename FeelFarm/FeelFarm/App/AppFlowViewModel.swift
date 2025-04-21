//
//  AppFlowViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AppFlowViewModel: ObservableObject {
    
    @Published var appState: AppState = .onboarding
    
    enum AppState {
        case onboarding
        case login
        case createProfile
        case tabbar
    }
    
    func checkAuthState() {
        if let user = Auth.auth().currentUser {
            print("자동 로그인된 사용자 UID: \(user.uid)")
            checkUserProfile(uid: user.uid)
        } else {
            print("스플래시 뷰 : 로그인 한 사용자 없음")
            appState = .login
        }
    }
    
    func checkUserProfile(uid: String) {
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        userRef.getDocument { snapshot, error in
            if let error = error {
                print("사용자 문서 조회 실패: \(error)")
                self.appState = .createProfile
                return
            }
            
            if let data = snapshot?.data(), data["nickname"] != nil {
                print("닉네임이 등록된 사용자 -> 메인 이동")
                self.appState = .tabbar
            } else {
                print("닉네임 정보 없음 -> 프로필 생성")
                self.appState = .createProfile
            }
        }
    }
    
    func createUserProfile(uid: String, nickname: String, profileImageName: String) {
        let userRef = Firestore.firestore().collection("users").document(uid)
        let user = UserModel(nickname: nickname, profileImageName: profileImageName)
        
        userRef.setData(user.toDictionary) { error in
            if let error = error {
                print("유저 프로필 생성 실패: \(error)")
                return
            }
            
            print("유저 프로필 생성 성공")
            DispatchQueue.main.async {
                self.appState = .tabbar
            }
        }
    }
}
