//
//  PostIt.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

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
