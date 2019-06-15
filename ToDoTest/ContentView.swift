//
//  ContentView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/08.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        TaskListView()
//        Text("Hello")
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
