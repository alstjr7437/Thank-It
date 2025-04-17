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
    
    func add(_ data: EntityRepresentable) async {
        do {
            guard let dataDictionary = data.asDictionary else { return }
            try await db.collection(data.entityName).addDocument(data: dataDictionary)
            print("✅ Thank added to Firestore")
        } catch {
            print("❌ Error adding Thank: \(error)")
        }
    }
}

extension Encodable {
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: object, options: [])
                as? [String: Any] else {
            return nil
        }
        
        return dictionary
    }
}
