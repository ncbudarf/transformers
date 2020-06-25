//
//  TransformerView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct TransformerView: View {    
    var body: some View{
        TransformerListView(viewModel: TransformerListViewModel())
    }
}
