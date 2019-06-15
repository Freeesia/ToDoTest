//
//  TaskData.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import Combine
import SwiftUI

final class TaskData: BindableObject {
    let didChange = PassthroughSubject<TaskData, Never>()
    private var _tasks: [Task] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    var tasks: [Task] {
        get { _tasks.filter { t in visibleDoneTasks || !t.isDone } }
    }
    
    var visibleDoneTasks = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func index(_ task:Task ) -> Int {
        _tasks.firstIndex{$0.id == task.id}!
    }
    
    func create(_ text:String, _ color:TaskColor) {
        _tasks.append(Task(text: text, color: color))
    }
    
    func toggleDone(_ task:Task) {
        _tasks[index(task)].isDone.toggle()
    }
    
    func delete(_ task:Task) {
        _tasks.remove(at: index(task))
    }
    
    func delete(_ index:Int) {
        delete(tasks[index])
    }
    
    static func mock(size:Int = 3) -> TaskData {
        let data = TaskData()
        data._tasks = (0..<size).map{_ in Task.mock()}
        return data
    }
}
