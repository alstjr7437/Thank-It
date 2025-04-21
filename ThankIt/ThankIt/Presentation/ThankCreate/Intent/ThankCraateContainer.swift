//
//  CraateContainer.swift
//  ThankIt
//
//  Created by 김민석 on 4/20/25.
//

import Combine
import Foundation

@MainActor
final class ThankCraateContainer: ObservableObject {
    @Published private(set) var state = ThankCreateState()
    
    func send(_ intent: ThankCreateIntent) {
        switch intent {
        case let .createThank(content, isPublic, isAnonymous, postIt, selectedDate):
            let userNickName: String = UserDefaults.standard.string(forKey: "userNickname") ?? ""
            let thank = Thank(
                id: UUID(),
                user: User(nickName: userNickName),
                isPublic: isPublic,
                isAnonymous: isAnonymous,
                content: content,
                postIt: postIt,
                displayDate: selectedDate
            )
            createThank(thank)
        }
    }
    
    private func createThank(_ thank: Thank) {
        Task {
            state.isLoading = true
            
            do {
                _ = try await FirebaseManager.shared.create(thank)
            } catch {
                state.errorMessage = error.localizedDescription
            }
            
            state.isLoading = false
            state.isSuccess = true
        }
    }
}
