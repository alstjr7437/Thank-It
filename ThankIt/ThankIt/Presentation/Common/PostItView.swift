//
//  PostIt.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct PostItView: View {
    let thank: Thank
    let size: CGFloat
    
    var body: some View {
        ZStack {
            PostItBackgroundView(postIt: thank.postIt)
                .shadow(radius: 4, x: 1, y: 4)

            VStack(alignment: .leading) {
                Text(thank.content)
                    .font(size < 300 ? .basicFont : .detailFont )
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
                if !thank.isAnonymous {
                    Text(thank.user.nickName)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, Metrics.nickNameBottomPadding)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(customPadding)
        }
        .frame(width: size, height: size)
    }
    
    // MARK: PostIt Content Padding
    
    private var customPadding: CGFloat {
        switch thank.postIt {
        case .apple:
            size < 300 ? Metrics.appleViewBasicPadding : Metrics.appleViewDetailPadding
        default :
            size < 300 ? Metrics.defaultPadding : Metrics.detailPadding
        }
    }
}

// MARK: - Constants

private extension PostItView {
    enum Metrics {
        static let appleViewBasicPadding = 30.0
        static let appleViewDetailPadding = 60.0
        static let defaultPadding = 15.0
        static let detailPadding = 30.0
        static let nickNameBottomPadding = -10.0
    }
}

// MARK: - Preview

#Preview {
    PostItView(thank: DummyData.Thanks[0], size: 200)
}
