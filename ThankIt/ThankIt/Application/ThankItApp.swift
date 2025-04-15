//
//  ThankItApp.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

@main
struct ThankItApp: App {
    var body: some Scene {
        WindowGroup {
            PostItView(        thank: Thank(
                user: User(nickName: "Kinder"),
                isPublic: true,
                isAnonymous: false,
                content: "문을 잡아줬어요",
                postIt: PostIt.clova,
                displayDate: Date()
            ))
        }
    }
}
