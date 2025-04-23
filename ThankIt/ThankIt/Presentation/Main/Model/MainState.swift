//
//  MainState.swift
//  ThankIt
//
//  Created by 김민석 on 4/19/25.
//

import Foundation

struct MainState {
    var selectedFlavor: UserScope = .all
    var thanks: [Thank] = []
    var selectedThank: Thank? = nil
    var userNickName: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.userNickName) ?? ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
}
