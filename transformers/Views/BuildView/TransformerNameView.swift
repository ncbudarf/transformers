//
//  TransformerNameView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct TransformerNameView: View {
    @ObservedObject var viewModel: BuildViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Text(self.viewModel.transformerName)
            .font(Font.system(size:30))
            .frame(width: geometry.size.width+20, height: 20, alignment: .bottom)//TODO: This height should go somewhere
            .foregroundColor(self.viewModel.currentFactionColor)
        }.padding([.bottom])
    }
}
