//
//  CreateNicknameViewModel.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

@Observable
class CreateNicknameViewModel {
    
    var nickname: String = ""
    var imageSelection: PhotosPickerItem? = nil
    var profileImage: UIImage?
    
    var showPotatoImage: Bool = false
    var isShowImagePicker: Bool = false
    var uploadLoading: Bool = false
    
    var appFlowViewModel: AppFlowViewModel
    let storage = Storage.storage().reference()
    let database = Firestore.firestore()
    
    init(appFlowViewModel: AppFlowViewModel) {
        self.appFlowViewModel = appFlowViewModel
    }
    
    func uploadProfileImage(with data: Data, fileName: String) async throws -> URL {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw URLError(.userAuthenticationRequired) // 더 적절한 에러
        }
        
        let storageRef = Storage.storage().reference()
        let profileRef = storageRef.child("profileImages").child(uid).child("\(fileName).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg" // contentType 명시

        // 데이터 업로드
        let _ = try await profileRef.putDataAsync(data, metadata: metadata)
        
        // 다운로드 URL 반환
        let downloadURL = try await profileRef.downloadURL()
        return downloadURL
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
                self.uploadLoading = false
                self.appFlowViewModel.appState = .tabbar
            }
        }
    }
    
    
    func uploadAndCreateProfile(image: UIImage) async {
        
        self.uploadLoading = true
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            print("이미지 변환 실패")
            return
        }
        
        do {
            let fileName = UUID().uuidString
            let downloadURL = try await uploadProfileImage(with: imageData, fileName: fileName)
            
            guard let uid = Auth.auth().currentUser?.uid else {
                print("사용자 UID 없음")
                return
            }
            
            self.createUserProfile(uid: uid, nickname: nickname, profileImageName: downloadURL.absoluteString)
        } catch {
            print("프로필 이미지 업로드 실패: \(error.localizedDescription)")
        }
    }
}
