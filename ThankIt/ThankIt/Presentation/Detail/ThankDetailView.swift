//
//  ThankDetailView.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

import SwiftUI

struct ThankDetailView: View {
    let thank: Thank
    
    var body: some View {
        VStack(spacing: 30) {
            PostItView(thank: thank, size: 300)
            EditButtonView()
        }
    }
    
    struct EditButtonView: View {
        var body: some View {
            HStack(spacing: 20) {
                Button {
                    // TODO: 수정하기 로직
                } label: {
                    Text("수정하기")
                        .frame(width: 125, height: 45)
                        .foregroundStyle(.black)
                        .background(.point)
                        .cornerRadius(8)
                }
                
                Button {
                    // TODO: 삭제하기 로직
                } label: {
                    Text("삭제하기")
                        .frame(width: 125, height: 45)
                        .foregroundStyle(.white)
                        .background(.red)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    ThankDetailView(thank: DummyData.Thanks[0])
}
