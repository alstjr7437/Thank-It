//
//  LoginContainer.swift
//  ThankIt
//
//  Created by 김민석 on 4/19/25.
//

import Foundation
import Combine

@MainActor
final class LoginContainer: ObservableObject {
    
    func send(_ intent: LoginIntent) {
        switch intent {
        case .saveNickName(let nickName):
            savedNickName(nickName)
        }
    }
    
    func savedNickName(_ nickName: String) {
        UserDefaults.standard.set(nickName, forKey: UserDefaultsKeys.userNickname)
        
        //MARK: 추후 파이어베이스 닉네임 저장
    }
}
