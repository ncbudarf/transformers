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
        _ = Alert(title: Text("Building Transformer"), dismissButton: .default(Text("ok")))//TODO:Abstract out Alert
        viewModel.submitButtonDisabled = true
        viewModel.request.addTransformer(transformer: viewModel.newTransformer.convertToTransformerToCreate(),
                                         completionHandler: { transformer in
            if let transformer = transformer {
                //TODO: alerts are supposed to show or something
                _ = Alert(title: Text("Transformer Created!"), dismissButton: .default(Text("ok")))//TODO:Abstract out Alert
                self.viewModel.updateTransformerList(with: transformer)
                self.viewModel.submitButtonDisabled = false
                self.viewModel.rerollTransformer()
            } else {
                _ = Alert(title: Text("Failed To Create Transformer"), message: Text("Please try again"), primaryButton: .default(Text("ok"), action: {}), secondaryButton: .default(Text("retry"), action: {
                        self.viewModel.submitButtonDisabled = true
                        self.submitTransformer()
                }))//TODO:Abstract out Alert
            }//TODO: SubmitButton not disabled for long enough
        })
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: self.submitTransformer) {
                Text(self.viewModel.submitButtonText())
                    .font(Font.system(size:25))
                    .fontWeight(.bold)
                    .padding()
                    .font(.title)
                    .foregroundColor(self.viewModel.submitButtonDisabled ? .gray : self.viewModel.currentFactionColor)//TODO:This should be in view model
            }.frame(maxWidth: .infinity)
            .disabled(self.viewModel.submitButtonDisabled)
        }
    }
}
