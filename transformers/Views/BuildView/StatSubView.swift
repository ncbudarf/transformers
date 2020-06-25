//
//  StatSubView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct StatSubView: View {
    var statViewModel: StatViewModel
    
    var body: some View {
        HStack {
            Text("\(statViewModel.statName):").frame(width: 40, height: 25)
            ZStack {
                Rectangle()
                    .fill(statViewModel.statColor)
                    .frame(width: 25, height: 25)
                Text(String(statViewModel.statValue))
            }
        }
    }
}
