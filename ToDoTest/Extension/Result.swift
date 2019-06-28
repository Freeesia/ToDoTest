//
//  Result.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/28.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation


public extension Result {
    init(_ success: Success?, _ failure: Failure?) {
        if let success = success {
            self = .success(success)
        } else if let failure = failure {
            self = .failure(failure)
        } else  {
            fatalError("Illegal combination found.\n Success: \(success as Any), Failure: \(failure as Any)")
        }
    }
}
