//
//  MainView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct MainView: View {
    let thanks: [Thank]
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var selectedFlavor: UserScope = .all
    
    var body: some View {
        // MARK: Picker
        HStack {
            Spacer()
            Picker("UserScope", selection: $selectedFlavor) {
                Text(UserScope.all.rawValue).tag(UserScope.all)
                Text(UserScope.me.rawValue).tag(UserScope.me)
            }
            .pickerStyle(.segmented)
            .frame(width: 100)
            .padding()
        }
        
        // MARK: Main Scroll
        ScrollView {
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(thanks) { thank in
                    PostItView(thank: thank)
                }
            }
        }
    }
}

// MARK: - User Scope
enum UserScope: String {
    case all = "All"
    case me = "Me"
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
            Thank(
                user: User(nickName: "Kinder"),
                isPublic: true,
                isAnonymous: false,
                content: "고민을 들어줬어요",
                postIt: .square(color: .yellow)),
        ]
    )
}
