//
//  UserViewModel.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/22.
//  Copyright © 2019 Jin. All rights reserved.
//

import Combine
import Firebase
import SwiftUI

final class UserViewModel : BindableObject {
    
    let didChange = PassthroughSubject<UserViewModel, Never>()
    private let userDidCreate = PassthroughSubject<(), Never>()
    private lazy var stateSubscriber = Subscribers.Assign(object: self, keyPath: \.isAuthenticated)
    
    var isAuthenticated: Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        Auth.auth().stateDidChange()
            .map { $0.user }
            .merge(with: userDidCreate.map { Auth.auth().currentUser })
//            .flatMap { user in
//                AnyPublisher<Document<Models.User>?, Error> { sub in
//                    guard let user = user else {
//                        _ = sub.receive(nil)
//                        sub.receive(completion:.finished)
//                        return
//                    }
//                    Document<Models.User>.get(documentID: user.uid) { res in
//                        switch res {
//                        case let .success(u):
//                            _ = sub.receive(u)
//                            sub.receive(completion:.finish)
//                        case let .failure(error):
//                            sub.receive(completion:.failure(error))
//                            
//                        }
//                    }
//                }
//                .replaceError(with: nil)
//            }
            .map{ ($0 != nil) }
            .receive(subscriber: stateSubscriber)
    }
    
    deinit {
        stateSubscriber.cancel()
    }
    
    func signIn(_ name: String, completion: @escaping (Result<(), Error>) -> Void = { _ in }) {
        if let _ = Auth.auth().currentUser {
            return
        }
        
        Auth.auth().signInAnonymously { authDataResult, error in
            switch Result(authDataResult, error)
            {
            case .success:
                completion(.success(()))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
}
