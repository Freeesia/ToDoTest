//
//  SignUpView.swift
//  ToDoTest
//
//  Created by Jin on 2019/06/23.
//  Copyright © 2019 Jin. All rights reserved.
//

import SwiftUI

struct SignUpView : View {
    @EnvironmentObject
    private var viewModel: UserViewModel
    @State
    private var name = ""
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .edgesIgnoringSafeArea(.top)
                .offset(x: 0, y:-100)
            
            VStack {
                Text("Name")
                    .font(.subheadline)
                    .underline()
                
                TextField($name, placeholder: Text("名前を入力してください"))
                    .frame(height:40)
                    .padding(.horizontal, 8.0)
                    .border(Color.gray, cornerRadius: 8)
                
                Button(action: { } ) {
                    Text("Sign in")
                        .foregroundColor(Color.white)
                }
                    .frame(height: 44.0)
                    .padding(.horizontal)
                    .background(Color.green, cornerRadius: 8.0)
            }
            .padding()
        }
    }
}

#if DEBUG
struct SignUpView_Previews : PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
#endif
