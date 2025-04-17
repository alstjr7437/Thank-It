//
//  FirebaseManager.swift
//  ThankIt
//
//  Created by 김민석 on 4/17/25.
//

import FirebaseFirestore

final class FirebaseManager {
    
    private init() {}
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    func create(_ data: EntityRepresentable) async throws {
        guard let dataDictionary = data.asDictionary else { return }
        try await db.collection(data.entityName.rawValue).addDocument(data: dataDictionary)
        print("✅ Thank added to Firestore")
    }
    
    func fetch<T: Decodable>(
        as type: T.Type,
        _ collectionType: CollectionType
    ) async throws -> [T] {
        let snapshot = try await db.collection(collectionType.rawValue).getDocuments()
        
        let items: [T] = try snapshot.documents.compactMap { doc in
            let data = try JSONSerialization.data(withJSONObject: doc.data())
            return try JSONDecoder().decode(T.self, from: data)
        }
        
        return items
    }
}
