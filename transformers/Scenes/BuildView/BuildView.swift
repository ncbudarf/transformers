//
//  BuildView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import SwiftUI

struct BuildView: View {
    @ObservedObject var viewModel: BuildViewModel = BuildViewModel(newTransformer: NewTransformer(team: .autobot))

    var body: some View {
        GeometryReader { geometry in
            ScrollView( .vertical) {
                VStack() {
                    FactionSelectionButtonsView(viewModel: self.viewModel)
                        .frame(width: geometry.size.width, height: 150, alignment: .center)//TODO: This height should go somewhere
                    //TODO: Faction selection needs a better indication that something has been selected
                    
                    TransformerNameView(viewModel: self.viewModel)
                    
                    PieChartView(pieChart: self.viewModel.pieChart)
                            .frame(width: geometry.size.width/1.5, height: geometry.size.width/1.5)

                    TotalPowerView(viewModel: self.viewModel)
                    
                    StatView(statViewModels: self.viewModel.statViewModels)
                                
                    HStack {
                        RerollTransformerView(viewModel: self.viewModel)
                        SubmitTransformerView(viewModel: self.viewModel)
                    }.frame(width: geometry.size.width, height: 50)
                }
            }
        }
    }
}
