//
//  BuildViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

class BuildViewModel: ObservableObject {
    var newTransformer: TransformerToCreate = TransformerToCreate()
    var pieChart: PieChart
    
    init() {
        self.pieChart = PieChart(newTransformer: newTransformer)
    }
}
