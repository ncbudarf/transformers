//
//  BuildView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import SwiftUI

struct BuildView: View {
    @ObservedObject var viewModel: BuildViewModel = BuildViewModel()
    
    var body: some View {
        Text("The content of the second view")
    }
}
