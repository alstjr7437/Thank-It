//
//  DummyData.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

struct DummyData {
    static let Thanks: [Thank] = [
        Thank(
            user: User(nickName: "Kinder"),
            isPublic: true,
            isAnonymous: false,
            content: "사탕을 줬어요",
            postIt: .clova),
        Thank(
            user: User(nickName: "Kinder"),
            isPublic: true,
            isAnonymous: false,
            content: "리뷰를 해줬어요",
            postIt: .apple),
        Thank(
            user: User(nickName: "Kinder"),
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .square(color: .yellow)),
        Thank(
            user: User(nickName: "Yoon"),
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova),
        Thank(
            user: User(nickName: "Gil"),
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova),
    ]
}
