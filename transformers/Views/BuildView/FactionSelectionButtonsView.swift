//
//  FactionSelectionButtonsView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct FactionSelectionButtonsView: View {
    @ObservedObject var viewModel: BuildViewModel
    
    private func autobotFactionSelection() {
        viewModel.rerollTransformer(to: .autobot)
    }
    
    private func deceptaconFactionSelection() {
        viewModel.rerollTransformer(to: .deceptacon)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Button(action: self.autobotFactionSelection) {
                    Image("autobotButtonIcon")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(ViewManager().autobotColor)
                        .padding()
                }.frame(maxWidth: .infinity)
                Button(action: self.deceptaconFactionSelection) {
                    Image("deceptaconButtonIcon")
                        .resizable()
                        .foregroundColor(ViewManager().deceptaconColor)
                        .scaledToFit().padding()
                }.frame(maxWidth: .infinity)
            }
        }
    }
}
