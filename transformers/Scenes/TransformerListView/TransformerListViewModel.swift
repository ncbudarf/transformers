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
    let request: RequestManager = RequestManager()
    @Published var transformers: [Transformer] = []
    var cancellables = Set<AnyCancellable>()
}

extension TransformerListViewModel {
    func loadTransformers() {
        let transformers: [Transformer] = DataManager().decodeTransformerList()
        guard !transformers.isEmpty else {
            request.getTransformers().sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { response in
                self.transformers = response.value.transformers
            }).store(in: &cancellables)
            return
        }
        self.transformers = transformers
    }
}

extension TransformerListViewModel {
    func removeElements(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        request.removeTransformer(with: transformers[index].id).sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: { response in
            self.transformers.remove(at: index)
            DataManager().encodeTransformerList(self.transformers)
        }).store(in: &cancellables)
    }
}
