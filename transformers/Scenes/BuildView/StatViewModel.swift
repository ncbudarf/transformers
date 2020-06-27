//
//  StatViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

struct StatViewModel {
    let statName: String
    var statValue: Int
    var statColor: Color
    
    init(statName: String, statValue: Int, statColor: Color) {
        self.statName = statName
        self.statValue = statValue
        self.statColor = statColor
    }
}
