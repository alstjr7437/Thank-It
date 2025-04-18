//
//  User.swift
//  ThankIt
//
//  Created by 김민석 on 4/15/25.
//

import Foundation

struct User: Codable {
    let nickName: String
}

extension User: EntityRepresentable {
    var documentID: String {
        nickName
    }
    var entityName: CollectionType {
        .users
    }
}
