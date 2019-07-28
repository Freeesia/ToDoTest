//
//  DocumentSnapshot.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/29.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import Firebase

extension DocumentSnapshot {
    func get<T>(_ key: String, _ default: T) -> T {
        data()?[key] as? T ?? `default`
    }
    
    func get<K: RawRepresentable, V>(_ key: K, _ default: V) -> V where K.RawValue == String {
        get(key.rawValue, `default`)
    }
}
