//
//  Auth.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/22.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import FirebaseAuth
import Combine

extension Auth {
    func stateDidChange(auth: Auth = .auth()) -> AnyPublisher<(auth:Auth, user:User?), Never> {
        AnyPublisher<(auth:Auth, user:User?), Never> { subscriber in
            let listener = auth.addStateDidChangeListener { (auth, user) in
                _ = subscriber.receive((auth, user))
            }
            subscriber.receive(subscription: AnySubscription { auth.removeStateDidChangeListener(listener) })
        }
    }
}
