//
//  MainView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI
import PopupView

struct MainView: View {
    @AppStorage("userNickname") private var userNickname: String = ""
    
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    // MARK: Picker
                    Picker("UserScope", selection: Binding(
                        get: { viewModel.state.selectedFlavor },
                        set: { viewModel.send(.selectFlavor($0)) }
                    )) {
                        Text(UserScope.all.rawValue).tag(UserScope.all)
                        Text(UserScope.me.rawValue).tag(UserScope.me)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: Metrics.pickerFrame)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    // MARK: Main Data
                    LazyVGrid(columns: columns, spacing: Metrics.verticalGridSpacing) {
                        ForEach(filteredThanks) { thank in
                            PostItView(thank: thank, size: Metrics.postItListSize)
                                .onTapGesture { viewModel.send(.selectThank(thank)) }
                        }
                    }
                }
                
                // MARK: 생성 버튼
                NavigationLink(destination: ThankCreateView()) {
                    Image(.createButton)
                        .resizable()
                        .frame(width: Metrics.createButtonFrame, height: Metrics.createButtonFrame)
                        .padding(.bottom, Metrics.createButtonPadding)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        // MARK: 팝업
        .popup(
            isPresented: Binding(
                get: { viewModel.state.selectedThank != nil },
                set: { if !$0 { viewModel.send(.selectThank(nil)) }}
            )
        ) {
            if let thank = viewModel.state.selectedThank {
                ThankDetailView(thank: thank, userNickName: userNickname)
            }
        } customize: {
            $0.backgroundColor(.black.opacity(0.5))
                .closeOnTapOutside(true)
                .closeOnTap(false)
        }
        
    }
    
    private(set) var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
}

// MARK: - Thanks Filter

extension MainView {
    private var filteredThanks: [Thank] {
        switch viewModel.state.selectedFlavor {
        case .all:
            return viewModel.state.thanks
        case .me:
            return viewModel.state.thanks.filter { $0.user.nickName == userNickname }
        }
    }
}

// MARK: - User Scope
enum UserScope: String {
    case all = "All"
    case me = "Me"
}

private extension MainView {
    enum Metrics {
        static let pickerFrame = 100.0
        static let createButtonFrame = 70.0
        static let createButtonPadding = 30.0
        static let verticalGridSpacing = 40.0
        static let postItListSize = 150.0
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
