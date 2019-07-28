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
    private var viewModel: TaskViewModel
    @EnvironmentObject
    private var user: UserViewModel
    var body: some View {
        NavigationView {
            Group {
                CreateTaskView()
                Toggle(isOn: viewModel.visibleDoneTasks) {
                    Text("完了済みタスク")
                }
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.tasks) { t in TaskRowView(task: t) }
                        .onDelete { i in self.viewModel.delete(i.first!) }
                }
                
            }
            .navigationBarTitle(Text("Todos"))
            .navigationBarItems(trailing:
                PresentationButton(destination: UserView().environmentObject(user))
                {
                    Image(systemName: "person.crop.circle").imageScale(.large)
                })
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
