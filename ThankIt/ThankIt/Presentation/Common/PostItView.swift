//
//  PostIt.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct PostItView: View {
    let thank: Thank
    
    var body: some View {
        ZStack {
            PostItBackgroundView(postIt: thank.postIt)

            VStack(alignment: .leading) {
                Text(thank.content)
                    .font(.basicFont)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack {
                    Spacer()
                    if !thank.isAnonymous {
                        Text(thank.user.nickName)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(customPadding)
        }
        .frame(width: Metrics.postItViewFrame, height: Metrics.postItViewFrame)
    }
    
    // MARK: PostIt Content Padding
    
    private var customPadding: CGFloat {
        switch thank.postIt {
        case .apple:
            Metrics.appleViewPadding
        default :
            Metrics.defaultPadding
        }
    }
}

// MARK: - Constants

private extension PostItView {
    enum Metrics {
        static let postItViewFrame = 200.0
        static let appleViewPadding = 40.0
        static let defaultPadding = 20.0
    }
}

// MARK: - Preview

#Preview {
    PostItView(
        thank: Thank(
            user: User(nickName: "Kinder"),
            isPublic: true,
            isAnonymous: false,
            content: "문을 잡아줬어요",
            postIt: PostIt.apple
        )
    )
}
