//
//  StatView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct StatView: View {
    let statViewModels: [StatViewModel]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<4, id: \.self) { index in
                    StatSubView(statViewModel: self.statViewModels[index]).frame(maxWidth: .infinity)
                }
            }
            HStack {
                ForEach(4..<8, id: \.self) { index in
                    StatSubView(statViewModel: self.statViewModels[index]).frame(maxWidth: .infinity)
                }
            }
        }
    }
}
