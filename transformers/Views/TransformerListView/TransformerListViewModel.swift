//
//  TransformerListViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import Combine

class TransformerListViewModel: ObservableObject {
    let request: Request = Request()
    @Published var transformers: [Transformer] = []
}

extension TransformerListViewModel {
    func loadTransformers() {
        let transformers: [Transformer] = DataManager().decodeTransformerList()
        guard !transformers.isEmpty else {
            request.getTransformers(completionHandler: { transformers in
                DispatchQueue.main.async {
                    self.transformers = transformers ?? []
                }
            })
            return
        }
        self.transformers = transformers
    }
}

extension TransformerListViewModel {
    func removeElements(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        request.removeTransformer(transformerID: transformers[index].id,
                                completionHandler: { success in
                                    DispatchQueue.main.async {
                                        self.transformers.remove(at: index)
                                        DataManager().encodeTransformerList(self.transformers)
                                    }
        })
    }
}
