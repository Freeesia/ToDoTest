//
//  CreateTaskView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/15.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct CreateTaskView : View {
    @State private var text = ""
    @State private var color = TaskColor.red
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 16.0) {
            HStack {
                TextField($text, placeholder: Text("新規タスク作成..."))
                    .frame(height: 40)
                    .padding(.horizontal, 8)
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .tapAction {
                        guard !self.text.isEmpty else {
                            return
                        }
                        self.clear()
                    }
            }
            
            HStack {
                ForEach(TaskColor.allCases.identified(by: \.self)) { c in
                    Image(systemName: self.color == c ? "circle.fill" : "circle")
                        .foregroundColor(c.color)
                        .tapAction { self.color = c }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func clear() {
        text = ""
        color = TaskColor.red
    }
}

#if DEBUG
struct CreateTaskView_Previews : PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
#endif
