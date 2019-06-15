//
//  TaskListView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/14.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct TaskListView : View {
    @State private var test = false
    var taskData: TaskData
    var body: some View {
        NavigationView {
            Group {
                Toggle(isOn: $test) {
                    Text("完了済みタスク")
                }
                .padding(.horizontal)
                
                List(taskData.tasks) { task in
                    if (self.test || !task.isDone) {
                        TaskRowView(task: task)
                    }
                }
            }
            .navigationBarTitle(Text("Todos"))
        }
    }
}

#if DEBUG
struct TaskListView_Previews : PreviewProvider {
    static var previews: some View {
        TaskListView(taskData: .mock())
    }
}
#endif
