//
//  RerollTransformerView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct RerollTransformerView: View {
    @ObservedObject var viewModel: BuildViewModel
    
    private func rerollTransformer() {
        viewModel.rerollTransformer()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: self.rerollTransformer) {
                Text(self.viewModel.reRollButtonText())
                    .font(Font.system(size:25))
                    .fontWeight(.bold)
                    .padding()
                    .font(.title)
                    .foregroundColor(self.viewModel.currentFactionColor)
            }.frame(maxWidth: .infinity)
        }
    }
}
