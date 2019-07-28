//
//  RootView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/29.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct RootView : View {
    @EnvironmentObject
    private var viewModel: UserViewModel
    var body: some View {
        if viewModel.isAuthenticated {
            return AnyView(TaskListView().environmentObject(TaskViewModel.mock()))
        } else {
            return AnyView(SignUpView())
        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
