//
//  CreateIntent.swift
//  ThankIt
//
//  Created by 김민석 on 4/20/25.
//

import Foundation

enum ThankCreateIntent {
    case createThank(form: CreateThankForm)
    case updateThank(data: Thank)
}
