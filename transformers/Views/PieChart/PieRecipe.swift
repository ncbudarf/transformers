//
//  pieItem.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

class PieRecipe {
    var title: String
    var value: Int
    var color: Color
    
    init(title: String = "", value: Int = 0, color: Color = .blue) {
        self.title = title
        self.value = value
        self.color = color
    }
}
