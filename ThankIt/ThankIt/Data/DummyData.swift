//
//  DummyData.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//
import Foundation

struct DummyData {
    static let Users: [User] = [
        User(nickName: "Kinder"),
        User(nickName: "Gil"),
        User(nickName: "Yoon")
    ]

    static let Thanks: [Thank] = [
        Thank(
            id: UUID(),
            user: Users[0],
            isPublic: true,
            isAnonymous: false,
            content: "Leeo가 사탕을 줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[0],
            isPublic: true,
            isAnonymous: false,
            content: "Jack이 리뷰를 해줬어요",
            postIt: .apple,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[0],
            isPublic: true,
            isAnonymous: false,
            content: "Gil이 고민을 들어줬어요",
            postIt: .square(color: .yellow),
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[0],
            isPublic: true,
            isAnonymous: false,
            content: "Saya가 디자인 피드백을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[1],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[0],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[2],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[2],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[2],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[2],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[2],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
        Thank(
            id: UUID(),
            user: Users[2],
            isPublic: true,
            isAnonymous: false,
            content: "고민을 들어줬어요",
            postIt: .clova,
            displayDate: Date()
        ),
    ]
}
