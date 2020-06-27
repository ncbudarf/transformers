//
//  BuildViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BuildViewModel: ObservableObject {
    @Published var newTransformer: NewTransformer
    @Published var pieChart: PieChart
    @Published var currentFactionColor: Color
    @Published var statViewModels: [StatViewModel]
    
    @State var submitButtonDisabled: Bool = false
    @State var buildAlert: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    let request: RequestManager = RequestManager()
    
    var transformerName: String {
        return newTransformer.name
    }
    
    init(newTransformer: NewTransformer) {
        self.newTransformer = newTransformer
        self.pieChart = PieChart(newTransformer: newTransformer)
        self.currentFactionColor = ViewManager().currentColor(for: newTransformer.team)
        self.statViewModels = newTransformer.statViewModels
    }
}

extension BuildViewModel {
    func addTransformer() {
        let transformer = newTransformer.convertToTransformerToCreate()
        request.addTransformer(transformer).sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: { response in
            self.updateTransformerList(with: response.value)
            self.submitButtonDisabled = false
            self.buildAlert = true
            self.rerollTransformer()
        }).store(in: &cancellables)
    }
}

extension BuildViewModel {
    func updateTransformerList(with transformer: Transformer) {
        var transformerList = DataManager().decodeTransformerList()
        transformerList.append(transformer)
        DataManager().encodeTransformerList(transformerList)//TODO:Probably should make sure this is a success
    }
}

extension BuildViewModel {
    func rerollTransformer(to faction: TransformerFaction = Bool.random() ? .autobot : .deceptacon) {
        DispatchQueue.main.async {
            self.newTransformer = NewTransformer(team: faction)
            self.pieChart = PieChart(newTransformer: self.newTransformer)
            self.currentFactionColor = ViewManager().currentColor(for: self.newTransformer.team)
            self.statViewModels = self.newTransformer.statViewModels
        }
    }
}

extension BuildViewModel {
    func totalPowerText() -> String {
        return "Total Power: \(self.newTransformer.power)"
    }
}

extension BuildViewModel {
    func reRollButtonText() -> String {
        return "Reroll"
    }
}

extension BuildViewModel {
    func submitButtonText() -> String {
        return "Submit"
    }
}
