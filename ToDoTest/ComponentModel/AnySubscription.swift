//
//  AnySubscription.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/22.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import Combine

final class AnySubscription : Subscription {
    private let cancellable: Cancellable
    
    init(_ cancel: @escaping () -> Void) {
        cancellable = AnyCancellable(cancel)
    }
    
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() {
        cancellable.cancel()
    }
    
    
}
