//
//  ContentView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-22.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        viewModel.hasToken ? AnyView(ContentTabView()) : AnyView(OverlayView(viewModel: viewModel))
    }
}

struct OverlayView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        Text("Fetching Token...").onAppear{
            self.viewModel.request.getToken(completionHandler: { success in
                if success {
                    DispatchQueue.main.async {
                        self.viewModel.hasToken = true
                    }
                } else {
                    //TODO: Handle retry
                }
            })
        }
    }
}

struct ContentTabView: View {
    var body: some View{
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
