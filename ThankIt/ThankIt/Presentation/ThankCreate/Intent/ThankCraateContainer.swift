//
//  CraateContainer.swift
//  ThankIt
//
//  Created by 김민석 on 4/20/25.
//

import Combine

@MainActor
final class ThankCraateContainer {
    @Published private(set) var state = ThankCreateState()
    
    func send(_ intent: ThankCreateIntent) {
        switch intent {
        case .createThank(let thank):
            createThank(thank)
        }
    }
    
    private func createThank(_ thank: Thank) {}
}
