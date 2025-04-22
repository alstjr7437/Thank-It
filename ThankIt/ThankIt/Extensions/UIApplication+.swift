//
//  UIApplication.swift
//  ThankIt
//
//  Created by 김민석 on 4/21/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
