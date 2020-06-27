//
//  BattleViewTeamPicker.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct BattleTeamPickerView: View {
    @ObservedObject var viewModel: BattleViewViewModel

    private func autobotFactionSelection() {
        viewModel.factionSelected(.autobot)
    }

    private func deceptaconFactionSelection() {
        viewModel.factionSelected(.deceptacon)
    }
    
    var body: some View {
        VStack{
            Text(viewModel.readyToBattleText())
                .font(Font.system(size:30))
                .foregroundColor(viewModel.readyToBattleTextColor())
            Text(viewModel.pickTeamText())
                .font(Font.system(size:25))
                .foregroundColor(viewModel.readyToBattleTextColor())
            HStack {
                Button(action: autobotFactionSelection) {
                    Image("autobotButtonIcon")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(ViewManager().autobotColor)
                        .padding()
                }.frame(maxWidth: .infinity)
                Button(action: deceptaconFactionSelection) {
                    Image("deceptaconButtonIcon")
                        .resizable()
                        .foregroundColor(ViewManager().deceptaconColor)
                        .scaledToFit().padding()
                }.frame(maxWidth: .infinity)
            }
        }
    }
}
