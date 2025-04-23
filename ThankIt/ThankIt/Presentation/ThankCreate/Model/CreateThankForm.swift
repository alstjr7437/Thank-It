//
//  CreateThankForm.swift
//  ThankIt
//
//  Created by 김민석 on 4/22/25.
//

import Foundation

struct CreateThankForm {
    var content: String = ""
    var isPublic: Bool = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isPublic)
    var isAnonymous: Bool = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAnonymous)
    var selectedDate: Date = Date()
    var selectedPostIt: PostIt = .square(color: .yellow)
    
    func toDomain(nickName: String, id: UUID? = nil) -> Thank {
        return Thank(
            id: id ?? UUID(),
            userNickName: nickName,
            isPublic: isPublic,
            isAnonymous: isAnonymous,
            content: content,
            postIt: selectedPostIt,
            displayDate: selectedDate
        )
    }
}
