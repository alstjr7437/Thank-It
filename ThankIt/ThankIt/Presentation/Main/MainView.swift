//
//  MainView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct MainView: View {
    let thanks: [Thank]
    var body: some View {
        List {
            ForEach(thanks) { thank in
                PostItView(thank: thank)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MainView(
        thanks: [
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
        ]
    )
}
