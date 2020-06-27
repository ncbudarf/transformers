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
    let request: RequestManager = RequestManager()
    
    func overlayText(_ failedToFetchToken: Bool) -> String {
        failedToFetchToken ? overlayTextFailure : overlayTextInitial
    }
    
    private let overlayTextInitial: String = "Fetching Token..."
    private let overlayTextFailure: String = "Failed to fetch Token"
    let retryButtonText: String = "Retry"
    
    @Published var hasToken: Bool
    
    init() {
        self.hasToken = request.hasToken
    }
}
