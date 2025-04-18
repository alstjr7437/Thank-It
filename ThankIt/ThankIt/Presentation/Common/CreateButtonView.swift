//
//  CreateButtonView.swift
//  ThankIt
//
//  Created by 김민석 on 4/18/25.
//

import SwiftUI

struct CreateButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("생성하기")
                .font(.buttonFont)
                .frame(width: 343, height: 52)
                .foregroundStyle(.white)
                .background(.point)
                .cornerRadius(8)
        }
    }
}

#Preview {
    CreateButtonView {
        print("버튼 클릭")
    }
}
