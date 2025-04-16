//
//  MainView.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

struct MainView: View {
    @AppStorage("userNickname") private var userNickname: String = ""
    
    private(set) var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var selectedFlavor: UserScope = .all
    
    let thanks: [Thank]

    var body: some View {
        NavigationStack {
            // MARK: Picker
            HStack {
                Spacer()
                
                Picker("UserScope", selection: $selectedFlavor) {
                    Text(UserScope.all.rawValue).tag(UserScope.all)
                    Text(UserScope.me.rawValue).tag(UserScope.me)
                }
                .pickerStyle(.segmented)
                .frame(width: Metrics.pickerFrame)
                .padding()
            }
            
            // MARK: Main Scroll
            ScrollView {
                LazyVGrid(columns: columns, spacing: Metrics.verticalGridSpacing) {
                    ForEach(filteredThanks) { thank in
                        PostItView(thank: thank)
                    }
                }
            }
            
            // MARK: CreateButton
            NavigationLink(destination: ThankCreateView()) {
                Image(.createButton)
                    .resizable()
                    .frame(width: Metrics.createButtonFrame, height: Metrics.createButtonFrame)
                    .padding(.bottom, Metrics.createButtonPadding)
            }
        }
    }
}

// MARK: - Thanks Filter

extension MainView {
    private var filteredThanks: [Thank] {
        switch selectedFlavor {
        case .all:
            return thanks
        case .me:
            return thanks.filter { $0.user.nickName == userNickname }
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
    }
}

// MARK: - Preview

#Preview {
    MainView(thanks: DummyData.Thanks)
}
