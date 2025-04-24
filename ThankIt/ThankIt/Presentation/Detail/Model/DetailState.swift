//
//  DetailState.swift
//  ThankIt
//
//  Created by 김민석 on 4/23/25.
//

struct DetailState {
    var isSuccess: (Bool, Bool) = (false, false)
    
    var thank: Thank
    let userNickName: String
    var isLoading = false
    var errorMessage: String? = nil
}
