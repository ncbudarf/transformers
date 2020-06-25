//
//  TotalPowerView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct TotalPowerView: View {
    @ObservedObject var viewModel: BuildViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Text(self.viewModel.totalPowerText())
            .font(Font.system(size:30))
            .frame(width: geometry.size.width+20, height: 20, alignment: .bottom)//TODO: This height should go somewhere
            .foregroundColor(self.viewModel.currentFactionColor)
        }.padding([.bottom])
    }
}
