//
//  TaskListView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/14.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct TaskListView : View {
    @EnvironmentObject
    private var taskData: TaskData
    @EnvironmentObject
    private var viewModel: UserViewModel
    var body: some View {
        NavigationView {
            Group {
                CreateTaskView()
                Toggle(isOn: $taskData.visibleDoneTasks) {
                    Text("完了済みタスク")
                }
                .padding(.horizontal)
                
                List {
                    ForEach(taskData.tasks) { t in TaskRowView(task: t) }
                        .onDelete { i in self.taskData.delete(i.first!) }
                }
                
            }
            .navigationBarTitle(Text("Todos"))
            .navigationBarItems(trailing:
                PresentationButton(
                    Image(systemName: "person.crop.circle").imageScale(.large),
                    destination: UserView().environmentObject(viewModel)))
        }
    }
}

#if DEBUG
struct TaskListView_Previews : PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
#endif
