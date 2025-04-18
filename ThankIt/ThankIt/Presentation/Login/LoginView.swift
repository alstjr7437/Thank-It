//
//  LoginView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct LoginView: View {
    
    @AppStorage("userNickname") private var savedNickname: String = ""
    @State private var nickname: String = ""
    
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
                TextField("닉네임", text: $nickname)
                    .font(.extraFont)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .background(Color.clear)
            }
            .frame(width: 250, height: 100)
            
            Spacer()
            
            CreateButtonView {
                savedNickname = nickname
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
