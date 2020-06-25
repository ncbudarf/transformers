//
//  TransformerListView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct TransformerListView: View {
    @ObservedObject var viewModel: TransformerListViewModel
    
    var body: some View{
        List {
            ForEach(viewModel.transformers, id: \.id) { item in
                TransformerListCellView(viewModel: TransformerListCellViewModel(transformer: item))
            }.onDelete { (indexSet) in
                self.viewModel.removeElements(at: indexSet)
            }
        }.onAppear{
            UITableView.appearance().tableFooterView = UIView()
        }
    }
}
