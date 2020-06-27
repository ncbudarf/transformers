//
//  ContentOverlayView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentOverlayView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State var failedToReturnToken: Bool = false
    
    private func fetchToken() {
        viewModel.request.getToken(completionHandler: { success in
            if success {
                DispatchQueue.main.async {
                    self.viewModel.hasToken = true
                }
            } else {
                self.failedToReturnToken = true
            }
        })
    }
    
    var body: some View {
        VStack {
            Text(viewModel.overlayText(failedToReturnToken)).onAppear{
                self.fetchToken()
            }
            if failedToReturnToken {
                Button(action: fetchToken) {
                    Text(viewModel.retryButtonText())
                }.padding()
            }
        }
        
    }
}
