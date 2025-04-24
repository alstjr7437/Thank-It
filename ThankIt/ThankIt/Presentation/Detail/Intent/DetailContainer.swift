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
        case .updatedThank(let id):
            updatedThank(id)
        }
    }
    
    private func updatedThank(_ id: String){
        Task {
            state.isLoading = true
            
            do {
                if let fetchedThank: Thank = try await FirebaseManager.shared.get(id, collectionType: .thank) {
                    state.thank = fetchedThank
                }
            } catch {
                state.errorMessage = error.localizedDescription
            }
            state.isLoading = false
            state.isSuccess = (true, false)
        }
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
            state.isSuccess = (false, true)
        }
    }
}
