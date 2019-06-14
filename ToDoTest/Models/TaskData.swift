//
//  TaskData.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import Foundation
import Combine

final class TaskData {
    let changed = PassthroughSubject<TaskData, Never>()
    
    var tasks: [Task] = [] {
        didSet{
            changed.send(self)
        }
    }
    
    var hideDoneTasks = true {
        didSet {
            changed.send(self)
        }
    }
    
    func index(_ task:Task ) -> Int {
        tasks.firstIndex{$0.id == task.id}!
    }
    
    func create(_ text:String, _ color:TaskColor) {
        tasks.append(Task(text: text, color: color))
    }
    
    func toggleDone(_ task:Task) {
        tasks[index(task)].isDone.toggle()
    }
    
    func delete(_ task:Task) {
        tasks.remove(at: index(task))
    }
    
    static func mock(size:Int = 3) -> TaskData {
        let data = TaskData()
        data.tasks = (0..<size).map{_ in Task.mock()}
        return data
    }
}
