//
//  APIClient.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-27.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import Combine

struct Response<T> {
    let value: T
    let response: URLResponse
}

struct APIClient {
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func run(_ request: URLRequest) -> AnyPublisher<Void, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { _ in return }
            .mapError { error in
                return error as Error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
