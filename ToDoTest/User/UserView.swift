//
//  UserView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/29.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct UserView : View {
    @EnvironmentObject
    private var viewModel: UserViewModel
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(1,contentMode: .fit)
                .frame(width: 200)
            
            Button(action: { self.viewModel.signOut() } ) {
                Text("Sign out")
                    .foregroundColor(.white)
            }
            .frame(height: 44)
            .padding(.horizontal)
            .background(Color.green, cornerRadius: 8.0)
        }
    }
}

#if DEBUG
struct UserView_Previews : PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
#endif
