//
//  ThankCreateView.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

import SwiftUI
import PopupView

struct ThankCreateView: View {
    
    @State private var form = CreateThankForm()
    @StateObject private var container = ThankCraateContainer()
    
    @Environment(\.dismiss) private var dismiss
    var onComplete: (() -> Void)
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ZStack(alignment: .topLeading) {
                        PostItBackgroundView(postIt: .square(color: form.selectedColor))
                            .shadow(radius: 4, x: 1, y: 4)

                        TextEditor(text: $form.content)
                            .padding(20)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            .font(.basicFont)
                    }
                    .frame(width: 350, height: 350)
                    .padding(.bottom, 20)

                    CreateSelectView(title: "공개 여부", isOn: $form.isPublic)
                    CreateSelectView(title: "익명 여부", isOn: $form.isAnonymous)
                    DatePickerOptionView(title: "날짜 선택", selectedDate: $form.selectedDate)
                    ColorPickerOptionView(title: "색상 선택", selectedColor: $form.selectedColor)
                }
                .padding()
            }
            Spacer()
            CreateButtonView {
                container.send(.createThank(form: form))
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onChange(of: [container.state.isSuccess, form.isPublic, form.isAnonymous] ) { _, new in
            let isSuccess = new[0], isPublic = new[1], isAnonymous = new[2]
            
            UserDefaults.standard.set(isPublic, forKey: UserDefaultsKeys.isPublic)
            UserDefaults.standard.set(isAnonymous, forKey: UserDefaultsKeys.isAnonymous)
            
            if isSuccess {
                onComplete()
                dismiss()
            }
        }
        .popup(
            isPresented: Binding(
                get: { container.state.isLoading },
                set: { _ in } // 사용자가 직접 닫지 못하도록 설정
            )
        ) {
            VStack(spacing: 16) {
                ProgressView("생성 중...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.white)
                    .tint(.white)
            }
            .padding(24)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.8)))
        }
    }
}

extension ThankCreateView {
    struct CreateSelectView: View {
        let title: String
        @Binding var isOn: Bool
        var body: some View {
            HStack {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .onChange(of: isOn) {
                        UIApplication.shared.endEditing()
                    }
            }
            .padding(.horizontal)
        }
    }
    
    struct DatePickerOptionView: View {
        let title: String
        @Binding var selectedDate: Date

        var body: some View {
            HStack {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .foregroundColor(.main)
            }
            .padding(.horizontal)
        }
    }
    
    struct ColorPickerOptionView: View {
        let title: String
        @Binding var selectedColor: PostItColor

        var body: some View {
            HStack() {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                HStack {
                    ForEach(PostItColor.allCases, id: \.self) { color in
                        Circle()
                            .fill(Color(color.rawValue))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: selectedColor == color ? 2 : 0)
                            )
                            .onTapGesture {
                                selectedColor = color
                                UIApplication.shared.endEditing()
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ThankCreateView{}
}
