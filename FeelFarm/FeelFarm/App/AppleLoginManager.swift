//
//  AppleManager.swift
//  FeelFarm
//
//  Created by Apple Coding machine on 4/13/25.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

class AppleLoginManager: NSObject {
    
    static let shared = AppleLoginManager()
    
    private var completion: ((Bool) -> Void)?
    private var anchor: ASPresentationAnchor?
    
    func startSignInWithAppleFlow(presentationAnchor: ASPresentationAnchor, completion: @escaping (Bool) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as (any ASAuthorizationControllerPresentationContextProviding)?
        controller.performRequests()
        
        self.completion = completion
        self.anchor = presentationAnchor
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIDCredential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
            completion?(false)
            return
        }
        let fullName = appleIDCredential.fullName
        
        let credential = OAuthProvider.appleCredential(withIDToken: tokenString, rawNonce: nil, fullName: fullName)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase 로그인 실패: \(error.localizedDescription)")
                self.completion?(false)
                return
            }
            
            print("Firebase 로그인 성공: \(authResult?.user.uid ?? "")")
            self.completion?(true)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("Apple 로그인 실패: \(error.localizedDescription)")
        completion?(false)
    }
}

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return anchor ?? UIWindow()
    }
}
