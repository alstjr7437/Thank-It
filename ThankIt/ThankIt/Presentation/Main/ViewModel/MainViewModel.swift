//
//  MainViewModel.swift
//  ThankIt
//
//  Created by 김민석 on 4/18/25.
//

import Foundation
import Combine

struct MainState {
    var thanks: [Thank] = []
    var selectedFlavor: UserScope = .all
    var selectedThank: Thank? = nil
    var isLoading: Bool = false
    var errorMessage: String? = nil
}

@MainActor
final class MainViewModel: ObservableObject {
    @Published private(set) var state = MainState()
    
    func send(_ intent: MainIntent) {
        switch intent {
        case .onAppear:
            fetchThanks()
            
        case .selectFlavor(let flavor):
            state.selectedFlavor = flavor
            
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
            } catch {
                state.errorMessage = error.localizedDescription
            }
            
            state.isLoading = false
        }
    }
}
