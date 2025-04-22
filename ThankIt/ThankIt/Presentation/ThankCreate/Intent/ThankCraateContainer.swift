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
        case let .createThank(form):
            createThank(form)
        }
    }
    
    private func createThank(_ thankForm: CreateThankForm) {
        guard let userNickName = UserDefaults.standard.string(forKey: "userNickname") else {
            state.errorMessage = "닉네임이 없습니다."
            return
        }
        
        let thank = thankForm.toDomain(nickName: userNickName)
        
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
