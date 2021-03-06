//
//  SubmitTransformerView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct SubmitTransformerView: View {
    @ObservedObject var viewModel: BuildViewModel

    private func submitTransformer() {
        viewModel.submitButtonDisabled = true
        viewModel.addTransformer()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: self.submitTransformer) {
                Text(self.viewModel.submitButtonText())
                    .font(Font.system(size:25))
                    .fontWeight(.bold)
                    .padding()
                    .font(.title)
                    .foregroundColor(self.viewModel.submitButtonDisabled ? .gray : self.viewModel.currentFactionColor)
                    .alert(isPresented: self.viewModel.$buildAlert) {
                        Alert(title: Text("Transformer Built"), dismissButton: .default(Text("ok")))
                    }
            }.frame(maxWidth: .infinity)
            .disabled(self.viewModel.submitButtonDisabled)
        }
    }
}
