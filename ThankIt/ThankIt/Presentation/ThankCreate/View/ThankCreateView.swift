//
//  ThankCreateView.swift
//  ThankIt
//
//  Created by 김민석 on 4/16/25.
//

import SwiftUI

struct ThankCreateView: View {
    
    @State private var form = CreateThankForm()
    @StateObject private var container = ThankCraateContainer()
    var state: ThankCreateState { return container.state }
    let thank: Thank?
    
    @Environment(\.dismiss) private var dismiss
    var onComplete: (() -> Void)
    
    private var isButtonDisabled: Bool {
        form.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: Metrics.mainSpacing) {
                        ZStack(alignment: .topLeading) {
                            PostItBackgroundView(postIt: form.selectedPostIt)
                                .shadow(radius: 4, x: 1, y: 4)
                            
                            TextEditor(text: $form.content)
                                .padding(Metrics.textEditorPadding)
                                .background(Color.clear)
                                .scrollContentBackground(.hidden)
                                .foregroundColor(.black)
                                .font(.basicFont)
                        }
                        .frame(
                            width: Metrics.inputViewWidth,
                            height: Metrics.inputViewHeight
                        )
                        .padding(.bottom, Metrics.inputViewBottomPadding)
                        
                        CreateSelectView(title: "공개 여부", isOn: $form.isPublic)
                        CreateSelectView(title: "익명 여부", isOn: $form.isAnonymous)
                        DatePickerView(title: "날짜 선택", selectedDate: $form.selectedDate)
                        PostItPickerView(title: "포스트잇 선택", selectedPostIt: $form.selectedPostIt)
                    }
                    .padding()
                }
                Spacer()
                CreateButtonView(text: thank == nil ? "생성하기" :"수정하기", isDisabled: isButtonDisabled) {
                    if let thank = thank {
                        container.send(.updateThank(form: form, id: thank.id.uuidString))
                    } else {
                        container.send(.createThank(form: form))
                    }
                }
            }
            if state.isLoading {
                VStack {
                    ProgressView(thank == nil ? "생성 중..." : "수정 중...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.white)
                        .tint(.white)
                }
                .padding(Metrics.loadingViewPadding)
                .background(
                    RoundedRectangle(
                        cornerRadius: Metrics.loadingCornerRadius
                    ).fill(Color.loadingBackground)
                )
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
        
        .onAppear {
            if let thank = thank {
                form.content = thank.content
                form.isPublic = thank.isPublic
                form.isAnonymous = thank.isAnonymous
                form.selectedDate = thank.displayDate
                form.selectedPostIt = thank.postIt
            }
        }
    }
}

private extension ThankCreateView {
    enum Metrics {
        static let mainSpacing = 10.0
        static let textEditorPadding = 20.0
        static let inputViewWidth = 350.0
        static let inputViewHeight = 350.0
        static let inputViewBottomPadding = 20.0
        
        static let loadingViewPadding = 24.0
        static let loadingCornerRadius = 12.0
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
    ThankCreateView(thank: nil){}
}
