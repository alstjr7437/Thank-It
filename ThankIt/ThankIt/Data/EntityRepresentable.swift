//
//  EntityRepresentable.swift
//  ThankIt
//
//  Created by 김민석 on 4/17/25.
//

protocol EntityRepresentable {
    var entityName: CollectionType { get }
    var documentID: String { get }
    var asDictionary: [String: Any]? { get }
}
