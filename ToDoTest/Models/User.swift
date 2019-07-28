//
//  User.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/29.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import Firebase

struct Models {
}

extension Models {
    struct User: FirestoreModelReadable, FirestoreModelWritable {
        enum Field: String {
            case name
        }
        
        static var collectionRef: CollectionReference {
            Firestore.firestore().collection("users")
        }
        
        var name: String
        
        init(_ snapshot: DocumentSnapshot) {
            name = snapshot.get(Field.name, "")
        }
        
        init(_ name: String) {
            self.name = name
        }
        
        var writeFields: [Field : Any] {
            [.name:name]
        }
    }
}
