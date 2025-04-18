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
    
    func create<T: EntityRepresentable>(_ data: T) async throws -> T {
        guard let dataDictionary = data.asDictionary else { throw Error.encodingFailed }
        try await db
            .collection(data.entityName.rawValue)
            .document(data.documentID)
            .setData(dataDictionary)
        
        return data
    }
    
    func fetch<T: Decodable>(
        as type: T.Type,
        _ collectionType: CollectionType
    ) async throws -> [T] {
        let snapshot = try await db.collection(collectionType.rawValue).getDocuments()
        
        let items: [T] = try snapshot.documents.compactMap { document in
            guard let jsonData = try? JSONSerialization.data(withJSONObject: document.data()),
                  let decoded = try? JSONDecoder().decode(T.self, from: jsonData)
            else {
                throw Error.decodingFailed
            }
            
            return decoded
        }
        
        return items
    }
extension FirebaseManager {
    enum Error: LocalizedError {
        case addFailed(underlying: Swift.Error)
        case fetchFailed(underlying: Swift.Error)
        case deleteFailed(underlying: Swift.Error)
        case updateFailed(underlying: Swift.Error)
        
        case decodingFailed
        case encodingFailed
        
        var errorDescription: String? {
            switch self {
            case .addFailed(let error):
                "데이터를 추가하는데 실패했습니다: \(error)"
            case .fetchFailed(let error):
                "데이터를 읽어오는데 실패했습니다: \(error)"
            case .deleteFailed(let error):
                "데이터를 삭제하는데 실패했습니다: \(error)"
            case .updateFailed(let error):
                "데이터를 업데이트하는데 실패했습니다: \(error)"
            case .encodingFailed:
                "데이터를 encoding하는데 실패했습니다"
            case .decodingFailed:
                "데이터를 decoding하는데 실패했습니다"
            }
        }
    }
}
