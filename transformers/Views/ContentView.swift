//
//  ContentView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-22.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    let request = Request()
    
//    var body: some View {
//        Text("Hello, World!").onAppear(perform: request.getToken)
//    }
    var body: some View {
        TabView {
            Text("The content of the first view")
                .tabItem {
                    Image("transform")
                    Text("Transform")
            }
            BuildView()
                .tabItem {
                    Image("build")
                    Text("Build")
            }
            Text("The content of the third view")
                .tabItem {
                    Image("battle")
                    Text("Battle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
