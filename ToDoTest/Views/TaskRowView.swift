//
//  TaskRowView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct TaskRowView : View {
//    @EnvironmentObject private var taskData: TaskData
    @State private var alertIsShown = false
    var task: Task
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: task.isDone ? "checkmark.square.fill" : "checkmark.square")
                .imageScale(.large)
            Text(task.text)
                .font(.title)

            Spacer()

            Image(systemName: "trash.fill")
                .imageScale(.large)
                .foregroundColor(.gray)
                .tapAction { self.alertIsShown = true }
//            Button(action: { self.alertIsShown = true }) {
//                Image(systemName: "trash.fill")
//                    .imageScale(.large)
//                    .foregroundColor(.gray)
//                    .padding(5) //Imageそのままだとた当たり判定が0なので当たり判定分作る
//            }
            .presentation($alertIsShown) {
                Alert(
                    title: Text("確認"),
                    message: Text("「\(self.task.text)」を削除しますか？"),
                    primaryButton: .destructive(Text("削除")),
                    secondaryButton: .cancel())
            }
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
