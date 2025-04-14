//
//  CreateNickname.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI
import FirebaseAuth

struct CreateNicknameView: View {
    
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    @Bindable var viewModel: CreateNicknameViewModel = .init()
    @FocusState private var isFocused: Bool
    
    
    var body: some View {
        VStack {
            CustomNavigationBar(text: "계정 생성")
            
            Spacer()
            
            contents
                .padding(.top, 30)
        }
    }
    
    /// 내부 컨텐츠
    private var contents: some View {
        VStack(alignment: .center, spacing: 64, content: {
            
            Text("감자 프로필을 설정하고 \n회원 가입을 완료해주세요")
                .font(.T22Semibold)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(viewModel.userProfileImage)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            
            inputUserNickname
            
            Spacer()
            
            MainButton(buttonType: viewModel.nickname.count > 2 ? .createOn : .createOff,
                       action: {
                guard let uid = Auth.auth().currentUser?.uid else {
                    print("로그인 사용자 없음")
                    return
                }
                
                appFlowViewModel.createUserProfile(uid: uid,
                                                   nickname: viewModel.nickname,
                                                   profileImageName: viewModel.userProfileImage)
            })
        })
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
    CreateNicknameView()
        .environmentObject(AppFlowViewModel())
}
