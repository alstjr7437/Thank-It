//
//  ThankItApp.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import SwiftUI

@main
struct ThankItApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(thanks: DummyData.Thanks)
        }
    }
}
