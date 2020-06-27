//
//  ArenaView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ArenaView: View {
    @ObservedObject var viewModel: BattleViewViewModel
    
    var body: some View {
        VStack {
            if viewModel.epicBattle() {
                Text("Optimus Prime and Predaking fight in an epic battle. There are no winners").font(Font.system(size:25)).padding().frame(alignment: .center).multilineTextAlignment(.center)
            } else {
                Text(viewModel.whoWon()).font(Font.system(size:25)).padding().frame(alignment: .center).multilineTextAlignment(.center)
                Text("Player Score: \(viewModel.victories.player)").font(Font.system(size:20)).frame(alignment: .leading)
                Text("Computer Score: \(viewModel.victories.computer)").font(Font.system(size:20)).frame(alignment: .leading)
            }
            
            VStack(alignment: .leading) {
                Text("Player Team:").font(Font.system(size:20)).frame(alignment: .leading)
                List(viewModel.playerTeamNames(), id: \.self) { name in
                    Text(name).font(Font.system(size:18))
                }
                
                Text("Computer Team:").font(Font.system(size:20)).frame(alignment: .leading)
                List(viewModel.computerTeamNames(), id: \.self) { name in
                    Text(name).font(Font.system(size:18))
                }.frame(maxWidth: .infinity)
            }.padding()
            
            Button(action: {
                self.viewModel.viewState = .pickTeam
            }) {
                Text("Exit Arena")
                }.font(Font.system(size:20)).padding()
        }
        
//        List(viewModel.displayVersionOfEvents(), id: \.self) { event in
//                Text(event)
//            }
    }
}


