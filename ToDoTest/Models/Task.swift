//
//  Task.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

struct Task : FirestoreModelReadable, FirestoreModelWritable, Identifiable {
    enum Field: String {
        case text
        case color
        case isDone
    }

    var id = UUID()
    var text:String
    var color: TaskColor
    var isDone = false
    
    static func mock() -> Task {
        .init(taskExamples.randomElement()!, TaskColor.allCases.randomElement()!)
    }
    
    static func subCollectionRef(_ doc: DocumentReference) -> CollectionReference {
        doc.collection("tasks")
    }
    
    init(_ snapshot: DocumentSnapshot) {
        text = snapshot.get(Field.text, "")
        color = TaskColor(rawValue: snapshot.get(Field.text, "")) ?? .red
        isDone = snapshot.get(Field.text, false)
    }
    
    init(_ text:String, _ color: TaskColor, _ isDone: Bool = false) {
        self.text = text
        self.color = color
        self.isDone = isDone
    }
    
    var writeFields: [Field: Any] {
        return [
            .text: text,
            .color: color.rawValue,
            .isDone: isDone
        ]
    }
}

private let taskExamples = [
    "Buy MacBook Pro",
    "Go Office",
    "Send E-mail to Bob",
    "Redesign website",
    "Buy iPhone X",
]
