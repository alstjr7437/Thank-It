//
//  LoginView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct LoginView: View {
    private let container = LoginContainer()
    @State var nickName: String = ""
    
    @Environment(\.dismiss) private var dismiss
    var onComplete: (() -> Void)
    
    init(nickName: String = "", onComplete: @escaping () -> Void) {
        self._nickName = State(initialValue: nickName)
        self.onComplete = onComplete
    }
    
    var body: some View {
        VStack(spacing: 60) {
            Spacer()
            Text("안녕하세요! 👋")
                .font(.extraFont)
                .padding(.top, -70)
            Text("당신의 감사함을 들려주기 전에\n닉네임을 알려주세요!")
                .font(.basicFont)
                .multilineTextAlignment(.center)
            
            ZStack {
                // 배경 포스트잇 스타일
                PostItBackgroundView(postIt: .square(color: .yellow))
                    .shadow(radius: 4, x: 1, y: 4)

                // 텍스트 필드
                TextField("닉네임", text: $nickName)
                    .font(.extraFont)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .background(Color.clear)
            }
            .frame(width: 250, height: 100)
            
            Spacer()
            
            CreateButtonView(text: "감사한 일 쓰러가기") {
                container.send(.saveNickName(nickName))
                onComplete()
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(onComplete: {})
}
