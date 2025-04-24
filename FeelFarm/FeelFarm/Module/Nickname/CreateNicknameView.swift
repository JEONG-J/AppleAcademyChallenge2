//
//  CreateNickname.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct CreateNicknameView: View {
    
    @Bindable var viewModel: CreateNicknameViewModel
    @FocusState private var isFocused: Bool
    @AppStorage("userNickname") private var nickname: String?
    
    init(appFlowViewModel: AppFlowViewModel) {
        self.viewModel = .init(appFlowViewModel: appFlowViewModel)
    }
    
    var body: some View {
        contents
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }
            .onChange(of: viewModel.imageSelection, { _, newItem in
                if let newItem {
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            viewModel.profileImage = uiImage
                        }
                    }
                }
            })
            .loadingOverlay(isLoading: viewModel.uploadLoading, loadingType: .profile)
    }
    
    /// 내부 컨텐츠
    private var contents: some View {
        VStack(alignment: .center, spacing: 30, content: {
            
            HStack(content: {
                
                Button(action: {
                    viewModel.appFlowViewModel.appState = .login
                }, label: {
                    Image(.chevronNavi)
                })
                
                Spacer()
            })
            
            VStack(content: {
                
                Text("감자 프로필을 설정하고 \n회원 가입을 완료해주세요")
                    .font(.T22Semibold)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 66)
                
                Spacer().frame(maxHeight: 60)
                
                PhotosPicker(selection: $viewModel.imageSelection, matching: .images, photoLibrary: .shared(), label: {
                    if let profileImage = viewModel.profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Image(.createProfile)
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                })
                
                Spacer().frame(maxHeight: 60)
                
                inputUserNickname
                
                Spacer()
                
                MainButton(buttonType: viewModel.nickname.count > 1 ? .createOn : .createOff,
                           action: {
                    Task {
                        if let image = viewModel.profileImage {
                            await viewModel.uploadAndCreateProfile(image: image)
                            nickname = viewModel.nickname
                        }
                    }
                })
            })
        })
        .background(Color.white)
        .safeAreaPadding(.horizontal, 16)
        .task {
            isFocused = true
        }
    }
    
    /// 유저 닉네임 입력
    private var inputUserNickname: some View {
        VStack(alignment: .leading) {
            Text("러너 닉네임을 입력해주세요")
                .font(.T16medium)
                .foregroundStyle(Color.gray05)
            
            TextField("닉네임 생성하기", text: $viewModel.nickname, prompt: makeText())
                .focused($isFocused)
            
            Divider().frame(maxWidth: .infinity)
                .foregroundStyle(Color.gray02)
        }
    }
    
    /// 텍스트 필드 플레이스 홀더 생성
    /// - Returns: 텍스트 값 반환
    private func makeText() -> Text {
        return Text("닉네임을 입력해주세요")
            .font(.T13Regular)
        
    }
}

#Preview {
    CreateNicknameView(appFlowViewModel: AppFlowViewModel())
}
