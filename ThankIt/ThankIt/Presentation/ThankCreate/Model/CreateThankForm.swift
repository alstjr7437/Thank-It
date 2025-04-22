//
//  CreateThankForm.swift
//  ThankIt
//
//  Created by 김민석 on 4/22/25.
//

import Foundation

struct CreateThankForm {
    var content: String = ""
    var isPublic: Bool = false
    var isAnonymous: Bool = false
    var selectedDate: Date = Date()
    var selectedColor: PostItColor = .yellow
    
    func toDomain(nickName: String) -> Thank {
        return Thank(
            id: UUID(),
            user: User(nickName: nickName),
            isPublic: isPublic,
            isAnonymous: isAnonymous,
            content: content,
            postIt: .square(color: selectedColor),
            displayDate: selectedDate
        )
    }
}
