//
//  FirestoreModel.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/29.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import Firebase

struct Document<T:FirestoreModel>: Hashable {
    var id: String {
        ref.documentID
    }
    let ref: DocumentReference
    let data: T
    
    init(_ snapshot: DocumentSnapshot) {
        ref = snapshot.reference
        data = .init(snapshot)
    }
}

protocol FirestoreModel: Hashable {
    associatedtype Field: Hashable & RawRepresentable
    init(_ snapshot: DocumentSnapshot)
    static var collectionRef: CollectionReference { get }
    static func subCollectionRef(_ document: DocumentReference) -> CollectionReference
}

extension FirestoreModel {
    static var collectionRef: CollectionReference {
        fatalError("need implementation either collectionRef or subCollectionRef(of:)")
    }
    
    static func subCollectionRef(_ document: DocumentReference) -> CollectionReference {
        fatalError("need implementation either collectionRef or subCollectionRef(of:)")
    }
}

protocol FirestoreModelReadable: FirestoreModel {}

extension Document where T: FirestoreModelReadable {
    static func get(documentID: String, completion: @escaping (Result<Document<T>?, Error>) -> Void) {
        T.collectionRef.document(documentID).getDocument { snapshot, error in
            completion(Result(snapshot, error)
                .map { snapshot in snapshot.exists ? .init(snapshot) : nil }
            )
        }
    }
    
    static func get<U>(parentDocument: Document<U>, documentID: String, completion: @escaping (Result<Document<T>?, Error>) -> Void) {
        T.subCollectionRef(parentDocument.ref).document(documentID).getDocument { snapshot, error in
            completion(Result(snapshot, error)
                .map { snapshot in snapshot.exists ? .init(snapshot) : nil }
            )
        }
    }
    
    static func listen(documentID: String, includeMetadataChanges: Bool = false, completion: @escaping (Result<Document<T>?, Error>) -> Void) -> ListenerRegistration {
        return T.collectionRef.document(documentID).addSnapshotListener(includeMetadataChanges: includeMetadataChanges) { snapshot, error in
            completion(Result(snapshot, error)
                .map { snapshot in snapshot.exists ? .init(snapshot) : nil }
            )
        }
    }
    
    static func get(queryBuilder: (Query) -> Query = { $0 }, completion: @escaping (Result<[Document<T>], Error>) -> Void) {
        queryBuilder(T.collectionRef).getDocuments { snapshot, error in
            switch Result(snapshot, error) {
            case let .success(snapshot):
                completion(.success(snapshot.documents.map { s in .init(s) }))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func get<U>(parentDocument: Document<U>, queryBuilder: (Query) -> Query = { $0 }, completion: @escaping (Result<[Document<T>], Error>) -> Void) {
        queryBuilder(T.subCollectionRef(parentDocument.ref)).getDocuments { snapshot, error in
            switch Result(snapshot, error) {
            case let .success(snapshot):
                completion(.success(snapshot.documents.map { s in .init(s) }))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func listen(queryBuilder: (Query) -> Query = { $0 }, includeMetadataChanges: Bool = false, completion: @escaping (Result<[Document<T>], Error>) -> Void) -> ListenerRegistration {
        return queryBuilder(T.collectionRef).addSnapshotListener(includeMetadataChanges: includeMetadataChanges) { snapshot, error in
            switch Result(snapshot, error) {
            case let .success(snapshot):
                completion(.success(snapshot.documents.map { s in .init(s) }))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func listen<U>(parentDocument: Document<U>, queryBuilder: (Query) -> Query = { $0 }, includeMetadataChanges: Bool = false, completion: @escaping (Result<[Document<T>], Error>) -> Void) -> ListenerRegistration {
        return queryBuilder(T.subCollectionRef(parentDocument.ref)).addSnapshotListener(includeMetadataChanges: includeMetadataChanges) { snapshot, error in
            switch Result(snapshot, error) {
            case let .success(snapshot):
                completion(.success(snapshot.documents.map { s in .init(s) }))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

protocol FirestoreModelWritable: FirestoreModel {
    var writeFields: [Field: Any] { get }
}

extension Document where T: FirestoreModelWritable, T.Field.RawValue == String {
    static func create(documentID: String? = nil, model: T, completion: @escaping (Result<(), Error>) -> Void) {
        let documentRef = documentID.map { T.collectionRef.document($0) } ?? T.collectionRef.document()
        documentRef.setData(model.writeFields.reduce(into: [:]) { $0[$1.key.rawValue] = $1.value }) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    static func create<U>(parentDocument: Document<U>, documentID: String? = nil, model: T, completion: @escaping (Result<(), Error>) -> Void) {
        let documentRef = documentID.map { T.subCollectionRef(parentDocument.ref).document($0) } ?? T.subCollectionRef(parentDocument.ref).document()
        documentRef.setData(model.writeFields.reduce(into: [:]) { $0[$1.key.rawValue] = $1.value }) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

extension Document where T: FirestoreModelWritable, T.Field.RawValue == String {
    func update(fields: [T.Field: Any], completion: @escaping (Result<(), Error>) -> Void = { _ in }) {
        ref.updateData(fields.reduce(into: [:]) { $0[$1.key.rawValue] = $1.value }) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

extension Document where T: FirestoreModelWritable {
    func delete(completion: @escaping (Result<(), Error>) -> Void = { _ in }) {
        ref.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
