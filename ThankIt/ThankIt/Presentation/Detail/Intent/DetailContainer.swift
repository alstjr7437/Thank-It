//
//  DetailContainer.swift
//  ThankIt
//
//  Created by 김민석 on 4/23/25.
//

import Combine

@MainActor
final class DetailContainer: ObservableObject {
    @Published private(set) var state: DetailState
    
    init(thank: Thank, userNickName: String) {
        state = DetailState(thank: thank, userNickName: userNickName)
    }
    
    func send(_ intent: DetailIntent) {
        switch intent {
        case .deleteThank(let thank):
            deleteThank(thank)
        }
    }
    
    private func updateThank(_ id: String){
        
    }
    
    
    private func deleteThank(_ thank: Thank){
        Task {
            state.isLoading = true
            
            do {
                _ = try await FirebaseManager.shared.delete(thank)
            } catch {
                state.errorMessage = error.localizedDescription
            }
            
            state.isLoading = false
            state.isSuccess = true
        }
    }
}
