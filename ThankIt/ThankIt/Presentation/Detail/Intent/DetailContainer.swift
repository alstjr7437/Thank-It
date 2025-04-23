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
        case .updateThank(let id):
            updateThank(id)
        case .deleteThank(let id):
            deleteThank(id)
        }
    }
    
    private func updateThank(_ id: String){
        
    }
    
    
    private func deleteThank(_ id: String){
        
    }
}
