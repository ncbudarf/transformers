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
                Text(viewModel.noWinnersText()).font(Font.system(size:25)).padding().frame(alignment: .center).multilineTextAlignment(.center)
            } else {
                Text(viewModel.whoWon()).font(Font.system(size:25)).padding().frame(alignment: .center).multilineTextAlignment(.center)
                Text(viewModel.playerScore()).font(Font.system(size:20)).frame(alignment: .leading)
                Text(viewModel.computerScore()).font(Font.system(size:20)).frame(alignment: .leading)
            }
            
            VStack(alignment: .leading) {
                Text(viewModel.playerTeam()).font(Font.system(size:20)).frame(alignment: .leading)
                List(viewModel.playerTeamNames(), id: \.self) { name in
                    Text(name).font(Font.system(size:18))
                }
                
                Text(viewModel.computerTeam()).font(Font.system(size:20)).frame(alignment: .leading)
                List(viewModel.computerTeamNames(), id: \.self) { name in
                    Text(name).font(Font.system(size:18))
                }.frame(maxWidth: .infinity)
            }.padding()
            
            Button(action: {
                self.viewModel.viewState = .pickTeam
            }) {
                Text(viewModel.exit())
                }.font(Font.system(size:20)).padding()
        }
    }
}


