//
//  TransformerListCellView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct TransformerListCellView: View {
    let viewModel: TransformerListCellViewModel
    
     var body: some View{
        VStack {
            HStack {
                Image(viewModel.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45.0, height: 45.0, alignment: .leading)
                    .foregroundColor(viewModel.currentColor)
                    .padding()
                VStack {
                    Text(viewModel.transformerName)
                        .font(Font.system(size:30))
                        .foregroundColor(viewModel.currentColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.transformerPower())
                        .font(Font.system(size:30))
                        .foregroundColor(viewModel.currentColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            HStack {
                ForEach(0..<4, id: \.self) { index in
                    StatSubView(statViewModel: self.viewModel.statViewModels[index]).frame(maxWidth: .infinity)
                }
            }
            HStack {
                ForEach(4..<8, id: \.self) { index in
                    StatSubView(statViewModel: self.viewModel.statViewModels[index]).frame(maxWidth: .infinity)
                }
            }.padding([.bottom], 10.0)
        }
        
    }
}
