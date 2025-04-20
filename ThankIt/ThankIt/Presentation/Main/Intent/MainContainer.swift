//
//  MainViewModel.swift
//  ThankIt
//
//  Created by 김민석 on 4/18/25.
//

import Foundation
import Combine

@MainActor
final class MainContainer: ObservableObject {
    @Published private(set) var state = MainState()
    
    func send(_ intent: MainIntent) {
        switch intent {
        case .onAppear:
            fetchThanks()
            
        case .selectFlavor(let flavor):
            state.selectedFlavor = flavor
            filterThanks()
            
        case .selectThank(let thank):
            state.selectedThank = thank
            
        case .clearError:
            state.errorMessage = nil
        }
    }
    
    private func fetchThanks() {
        Task {
            state.isLoading = true
            do {
                let thanks = try await FirebaseManager.shared.fetch(as: Thank.self, .thank)
                state.thanks = thanks
                filterThanks()
            } catch {
                state.errorMessage = error.localizedDescription
            }
            
            state.isLoading = false
        }
    }
    
    private func filterThanks() {
        switch state.selectedFlavor {
        case .all:
            state.filteredThanks = state.thanks
        case .me:
            state.filteredThanks = state.thanks.filter { $0.user.nickName == state.userNickName }
        }
    }
}
