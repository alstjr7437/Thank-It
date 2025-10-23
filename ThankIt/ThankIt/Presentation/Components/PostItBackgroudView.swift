//
//  PostItBackgroudView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct PostItBackgroundView: View {
    let postIt: PostIt

    var body: some View {
        switch postIt {
        case .square(let colorName):
            Color(colorName.rawValue)

        case .clova:
            Image("ClovaPost")
                .resizable()
                .scaledToFill()

//        case .apple:
//            Image("ApplePost")
//                .resizable()
//                .scaledToFill()
        }
    }
}
