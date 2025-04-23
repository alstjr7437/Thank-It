//
//  MainView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI
import PopupView

struct MainView: View {
    @StateObject private var container = MainContainer()
    var state: MainState { return container.state }
    
    private(set) var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    // MARK: Picker
                    Picker("UserScope", selection: Binding(
                        get: { state.selectedFlavor },
                        set: { container.send(.selectFlavor($0)) }
                    )) {
                        Text(UserScope.all.rawValue).tag(UserScope.all)
                        Text(UserScope.me.rawValue).tag(UserScope.me)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if !state.isLoading {
                        // MARK: Main Data
                        LazyVGrid(columns: columns, spacing: Metrics.verticalGridSpacing) {
                            ForEach(state.thanks) { thank in
                                PostItView(thank: thank, size: Metrics.postItListSize)
                                    .onTapGesture { container.send(.selectThank(thank)) }
                            }
                        }
                    }
                }
                .refreshable {
                    container.send(.onAppear)
                }
                
                // MARK: 생성 버튼
                NavigationLink(destination: ThankCreateView(create: true, thank: nil) {
                    container.send(.onAppear)
                }) {
                    Image(.createButton)
                        .resizable()
                        .frame(width: Metrics.createButtonFrame, height: Metrics.createButtonFrame)
                        .padding(.bottom, Metrics.createButtonPadding)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                if state.isLoading {
                    ProgressView("불러오는 중")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
            .navigationBarItems(leading:Text("Thanks").font(.extraFont))
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: LoginView(nickName: state.userNickName) {
                        container.send(.refreshNickName)
                        container.send(.onAppear)
                    },
                    label: {
                        Image(systemName: "person.fill")
                            .font(.titleFont)
                            .foregroundColor(.point)
                    }
                )
            )
        }
        // MARK: 화면 Load
        .onAppear {
            container.send(.onAppear)
            container.send(.refreshNickName)
        }
        
        // MARK: 팝업 화면
        .popup(
            isPresented: Binding(
                get: { state.selectedThank != nil },
                set: { if !$0 { container.send(.selectThank(nil)) }}
            )
        ) {
            if let thank = state.selectedThank {
                ThankDetailView(thank: thank, userNickName: state.userNickName)
            }
        } customize: {
            $0.backgroundColor(.black.opacity(0.5))
                .closeOnTapOutside(true)
                .closeOnTap(false)
        }
        
        // MARK: 에러 화면
        .alert("에러", isPresented: Binding<Bool>(
            get: { state.errorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    container.send(.clearError)
                }
            }
        )) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(state.errorMessage ?? "알 수 없는 에러가 발생했어요.")
        }
    }
}

private extension MainView {
    enum Metrics {
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
