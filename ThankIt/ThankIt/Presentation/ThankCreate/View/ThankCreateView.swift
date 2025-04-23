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
    var state: ThankCreateState { return container.state }
    let create: Bool
    let thank: Thank?
    
    @Environment(\.dismiss) private var dismiss
    var onComplete: (() -> Void)
    
    private var isButtonDisabled: Bool {
        form.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        // MARK: View
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ZStack(alignment: .topLeading) {
                        PostItBackgroundView(postIt: form.selectedPostIt)
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
                    DatePickerView(title: "날짜 선택", selectedDate: $form.selectedDate)
                    PostItPickerView(title: "포스트잇 선택", selectedPostIt: $form.selectedPostIt)
                }
                .padding()
            }
            Spacer()
            CreateButtonView(isDisabled: isButtonDisabled) {
                if create {
                    container.send(.createThank(form: form))
                } else {
                    if let thank = thank {
                        container.send(.updateThank(data: thank))
                    }
                    
                }
            }
        }
        
        // MARK: Keyboard
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        
        // MARK: State Change
        .onChange(of: [state.isSuccess, form.isPublic, form.isAnonymous] ) { _, new in
            let isSuccess = new[0], isPublic = new[1], isAnonymous = new[2]
            
            UserDefaults.standard.set(isPublic, forKey: UserDefaultsKeys.isPublic)
            UserDefaults.standard.set(isAnonymous, forKey: UserDefaultsKeys.isAnonymous)
            
            if isSuccess {
                onComplete()
                dismiss()
            }
        }
        
        // MARK: Loading
        .popup(
            isPresented: Binding(
                get: { state.isLoading },
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

// MARK: - 생성 뷰 컴포넌트들

extension ThankCreateView {
    // MARK: Toggle Components
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
    
    // MARK: Date Components
    struct DatePickerView: View {
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
    
    // MARK: PostItPicker Components
    struct PostItPickerView: View {
        let title: String
        @Binding var selectedPostIt: PostIt

        var body: some View {
            HStack {
                Text(title)
                    .font(.categoryFont)
                Spacer()
                HStack {
                    ForEach(PostIt.allCases, id: \.self) { postit in
                        PostItBackgroundView(postIt: postit)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Group {
                                    if selectedPostIt == postit {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.red)
                                            .offset(x: 10, y: -10)
                                    }
                                }
                            )
                            .onTapGesture {
                                selectedPostIt = postit
                                UIApplication.shared.endEditing()
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview

#Preview {
    ThankCreateView(create: true, thank: nil){}
}
