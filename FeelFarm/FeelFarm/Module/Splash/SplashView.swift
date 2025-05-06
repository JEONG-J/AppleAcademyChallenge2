//
//  SplashView.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/14/25.
//

import SwiftUI
import FirebaseAuth

struct SplashView: View {
    
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    @State private var showLoginButtons = false
    private var timeInterval: TimeInterval = 0.8
    
    var body: some View {
        VStack {
            Spacer()
            
            topLogo
                .offset(y: showLoginButtons ? -100 : 0)
                .animation(.easeInOut(duration: timeInterval), value: showLoginButtons)
                        
            Spacer()
            
            if showLoginButtons {
                loginGroup
                    .transition(.opacity.combined(with: .blurReplace))
                
                Spacer().frame(height: 100)
            }
        }
        .onChange(of: appFlowViewModel.appState, { _, newValue in
            if newValue == .login {
                withAnimation(.easeInOut(duration: timeInterval)) {
                    showLoginButtons = true
                }
            }
        })
        .task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            appFlowViewModel.checkAuthState()
        }
        .background(Color.white)
    }
    
    /// 상단 로고
    private var topLogo: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0, content: {
            Text("FeelFarm")
                .font(.HeadLineLogo)
                .foregroundStyle(Color.feelFarmOrange)
            
            Image(.logo)
                .resizable()
                .frame(width: 64, height: 66)
            
        })

    }
    
    /// 로그인 버튼 그룹
    private var loginGroup: some View {
        
        Button(action: {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                print("presentationAnchor를 찾을 수 없음")
                return
            }
            
            AppleLoginManager.shared.startSignInWithAppleFlow(presentationAnchor: window, completion: { result in
                if result, let uid = Auth.auth().currentUser?.uid {
                    appFlowViewModel.checkUserProfile(uid: uid)
                } else {
                    print("로그인 실패")
                }
            })
        }, label: {
            Image(.apple)
        })
    }
}

#Preview {
    SplashView()
        .environmentObject(AppFlowViewModel())
}
