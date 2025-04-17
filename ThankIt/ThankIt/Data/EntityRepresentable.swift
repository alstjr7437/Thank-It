//
//  EntityRepresentable.swift
//  ThankIt
//
//  Created by 김민석 on 4/17/25.
//

protocol EntityRepresentable {
    var entityName: String { get }
    var asDictionary: [String: Any]? { get }
}
