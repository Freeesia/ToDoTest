//
//  TaskRowView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct TaskRowView : View {
    @EnvironmentObject
    private var viewModel: TaskViewModel
    var task: Task
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: task.isDone ? "checkmark.circle.fill" : "checkmark.circle")
                .imageScale(.large)
                .tapAction { self.viewModel.toggleDone(self.task) }

            Text(task.text)

            Spacer()
        }
        .padding()
        .background(task.color.color.opacity(0.8))
        .cornerRadius(8)
    }
}

#if DEBUG
struct TaskRowView_Previews : PreviewProvider {
    static var previews: some View {
        TaskRowView(task: .mock())
    }
}
#endif
