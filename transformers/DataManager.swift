//
//  DataManager.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

class DataManager {
    public func encodeTransformerList(_ transformers: [Transformer]) { //TODO: This is a sort of best case scenario and doesn't really handle failure
        let encoder = JSONEncoder()
        var data: [Data] = []
        transformers.forEach { transformer in
            if let encoded = try? encoder.encode(transformer) {
                data.append(encoded)
            }
        }
        UserDefaults.standard.set(data, forKey: "transformersList")
    }
    
    public func decodeTransformerList() -> [Transformer] {//TODO: This is a sort of best case scenario and doesn't really handle failure
        var transformers: [Transformer] = []
        if let data = UserDefaults.standard.object(forKey: "transformersList") as? [Data] {
            let decoder = JSONDecoder()
            data.forEach { element in
                if let transformer = try? decoder.decode(Transformer.self, from: element) {
                    transformers.append(transformer)
                }
            }
        }
        return transformers
    }
}
