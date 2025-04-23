//
//  ThankItApp.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

@main
struct ThankItApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage(UserDefaultsKeys.userNickName) var userNickname: String = ""
    
    var body: some Scene {
        WindowGroup {
            if userNickname.isEmpty {
                LoginView(onComplete: {})
            } else {
                MainView()
            }
        }
    }
}
