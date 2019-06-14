//
//  TaskRowView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/09.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct TaskRowView : View {
    @EnvironmentObject private var taskData: TaskData?
    @State private var alertIsShown = false
    var task: Task
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if(task.isDone) {
                Image(systemName: "checkmark.square.fill")
                    .imageScale(.large)
            }else{
                Image(systemName: "checkmark.square")
                    .imageScale(.large)
            }
            Text(task.text)
                .font(.title)

            Spacer()
            
            Button(action: { self.alertIsShown = true }) {
                Image(systemName: "trash.fill")
                    .imageScale(.large)
                    .padding(5) //Imageそのままだとた当たり判定が0なので当たり判定分作る
                    .foregroundColor(.gray)
            }
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
