//
//  FirebaseManager.swift
//  ThankIt
//
//  Created by 김민석 on 4/17/25.
//

import FirebaseFirestore

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    let db = Firestore.firestore()
    
    private init() {}
    
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
        _ collectionType: CollectionType,
        whereFeild: String? = nil,
        equalData: Any? = nil,
        order: String? = nil,
        count: Int = 0
    ) async throws -> [T] {
        var query: Query = db.collection(collectionType.rawValue)
        
        if let whereFeild = whereFeild, let equalData = equalData {
            query = query.whereField(whereFeild, isEqualTo: equalData)
        }
        if let order = order { query = query.order(by: order, descending: true) }
        if count > 0 { query = query.limit(to: count) }

        let snapshot = try await query.getDocuments()
        
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
    
    func delete(_ data: EntityRepresentable) async throws -> Bool {
        try await db
            .collection(data.entityName.rawValue)
            .document(data.documentID)
            .delete()
        
        return true
    }
    
    func update(_ updateData: EntityRepresentable) async throws -> Bool {
        guard let dataDictionary = updateData.asDictionary else { throw Error.encodingFailed }
        
        try await db
            .collection(updateData.entityName.rawValue)
            .document(updateData.documentID)
            .updateData(dataDictionary)
        
        return true
    }
    
    func get<T: Decodable>(_ id: String, collectionType: CollectionType) async throws -> T? {
        let snapshot = try await db
            .collection(collectionType.rawValue)
            .whereField("id", isEqualTo: id)  // "id" 필드를 기준으로 쿼리
            .limit(to: 1)  // 최대 1개의 결과만 가져옴
            .getDocuments()

        // 첫 번째 문서를 가져와서 데이터 디코딩
        guard let document = snapshot.documents.first else {
            throw Error.fetchFailed(underlying: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "문서가 존재하지 않습니다."]))
        }

        guard let jsonData = try? JSONSerialization.data(withJSONObject: document.data()),
              let decoded = try? JSONDecoder().decode(T.self, from: jsonData) else {
            throw Error.decodingFailed
        }

        return decoded
    }
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
