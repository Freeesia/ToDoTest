//
//  Task.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import SwiftUI

struct Task : Equatable, Hashable, Identifiable {
    var id = UUID()
    var text:String
    var color: TaskColor
    var isDone = false
    
    static func mock() -> Task {
        .init(text: taskExamples.randomElement()!, color: TaskColor.allCases.randomElement()!)
    }
}

private let taskExamples = [
    "Buy MacBook Pro",
    "Go Office",
    "Send E-mail to Bob",
    "Redesign website",
    "Buy iPhone X",
]
