//
//  MainViewModel.swift
//  ThankIt
//
//  Created by 김민석 on 4/18/25.
//

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
            fetchThanks()
            
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
                let flavor = state.selectedFlavor
                let thanks: [Thank]
                
                switch flavor {
                case .all:
                    thanks = try await FirebaseManager.shared.fetch(
                        as: Thank.self,
                        .thank,
                        order: "displayDate",
                        count: 30
                    )
                case .me:
                    thanks = try await FirebaseManager.shared.fetch(
                        as: Thank.self,
                        .thank,
                        whereFeild: "userNickName",
                        equalData: state.userNickName,
                        order: "displayDate",
                    )
                }

                state.thanks = thanks
                state.filteredThanks = thanks // filteredThanks도 바로 사용

            } catch {
                state.errorMessage = error.localizedDescription
            }
            
            state.isLoading = false
        }
    }
}
