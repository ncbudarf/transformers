//
//  ContentViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    let request: Request = Request()
    
    @Published var hasToken: Bool
    
    init() {
        self.hasToken = request.hasToken
    }
}
