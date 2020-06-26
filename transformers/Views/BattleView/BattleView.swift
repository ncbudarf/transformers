//
//  BattleView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct BattleView: View {
    @ObservedObject var viewModel: BattleViewViewModel
    
    var body: some View{
        switch viewModel.viewState {
        case .pickTeam:
            return Text("pick team")
        case .battle:
            return Text("battle")
        default:
            return Text("pick team")
        }
    }
}
