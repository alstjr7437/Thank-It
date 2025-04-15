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
    case square(color: String)
    case clova
    case apple
}

