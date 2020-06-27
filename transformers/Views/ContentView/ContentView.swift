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
        viewModel.hasToken ? AnyView(ContentTabView()) : AnyView(ContentOverlayView(viewModel: viewModel))
    }
}

struct ContentTabView: View {
    var body: some View{
        TabView {
            TransformerView()
                .tabItem {
                    Image("transform")
                    Text("Transform")
            }
            BuildView()
                .tabItem {
                    Image("build")
                    Text("Build")
            }
            BattleView()
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
