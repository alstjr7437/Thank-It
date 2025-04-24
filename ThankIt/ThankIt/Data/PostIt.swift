//
//  PostIt.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

enum PostIt: Codable, CaseIterable, Hashable {
    case square(color: PostItColor)
    case clova
//    case apple
    
    static var allCases: [PostIt] {
//        var cases: [PostIt] = [.clova, .apple]
        var cases: [PostIt] = [.clova]
        cases.append(contentsOf: PostItColor.allCases.map { .square(color: $0) })
        return cases
    }
}

enum PostItColor: String, Codable, CaseIterable {
    case yellow = "MainColor"
    case pink = "PostColor1"
    case blue = "PostColor2"
    case purple = "PostColor3"
}
