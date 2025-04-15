//
//  Thank.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import Foundation

struct Thank {
    let user: User
    let isPublic: Bool
    let isAnonymous: Bool
    let content: String
    let postIt: PostIt
    let displayDate: Date
}

enum PostIt {
    case square(color: PostItColor)
    case clova
    case apple
}

enum PostItColor: String {
    case yellow = "MainColor"
    case pink = "PostColor1"
    case blue = "PostColor2"
    case purple = "PostColor3"
}
