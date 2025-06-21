//
//  CreateButtonView.swift
//  ThankIt
//
//  Created by 김민석 on 4/18/25.
//

import SwiftUI

struct CreateButtonView: View {
    let text: String
    var isDisabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.buttonFont)
                .frame(width: Metrics.buttonWidth, height: Metrics.buttonHeight)
                .foregroundStyle(.white)
                .background(isDisabled ? Color.gray : .point)
                .cornerRadius(Metrics.conerRadius)
        }
        .disabled(isDisabled)
    }
}

private extension CreateButtonView {
    enum Metrics {
        static let buttonWidth = 343.0
        static let buttonHeight = 52.0
        static let conerRadius = 8.0
    }
}

#Preview {
    CreateButtonView(text: "생성하기") {
        print("버튼 클릭")
    }
}
