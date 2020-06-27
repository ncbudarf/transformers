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
        viewModel.hasToken ? AnyView(ContentTabView(viewModel: viewModel)) : AnyView(ContentOverlayView(viewModel: viewModel))
    }
}

struct ContentTabView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View{
        TabView {
            TransformerView()
                .tabItem {
                    Image("transform")
                    Text(viewModel.transformerText())
            }
            BuildView()
                .tabItem {
                    Image("build")
                    Text(viewModel.buildText())
            }
            BattleView()
                .tabItem {
                    Image("battle")
                    Text(viewModel.battleText())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
