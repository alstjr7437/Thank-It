//
//  ThankDetailView.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

import SwiftUI

struct ThankDetailView: View {
    let thank: Thank
    let userNickName: String
    
    var body: some View {
        VStack(spacing: 30) {
            PostItView(thank: thank, size: Metrics.detailPostItSize)
            
            if userNickName == thank.userNickName {
                EditButtonView()
            }
        }
    }
    
    struct EditButtonView: View {
        var body: some View {
            HStack(spacing: 20) {
                Button {
                    // TODO: 수정하기 로직
                } label: {
                    Text("수정하기")
                        .frame(width: Metrics.buttonWidthFrame, height: Metrics.buttonHeightFrame)
                        .foregroundStyle(.black)
                        .background(.point)
                        .cornerRadius(Metrics.buttonConerRadius)
                        .shadow(radius: 4, x: 4, y: 4)
                }
                
                Button {
                    // TODO: 삭제하기 로직
                } label: {
                    Text("삭제하기")
                        .frame(width: Metrics.buttonWidthFrame, height: Metrics.buttonHeightFrame)
                        .foregroundStyle(.white)
                        .background(.red)
                        .cornerRadius(Metrics.buttonConerRadius)
                        .shadow(radius: 4, x: 4, y: 4)
                }
            }
        }
    }
}

private extension ThankDetailView {
    enum Metrics {
        static let buttonWidthFrame = 125.0
        static let buttonHeightFrame = 45.0
        static let buttonConerRadius = 8.0
        static let detailPostItSize = 300.0
    }
}

#Preview {
    ThankDetailView(thank: DummyData.Thanks[0], userNickName: "Kinder")
}
