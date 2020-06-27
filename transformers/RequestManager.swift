//
//  Request.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-22.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import Combine

enum RequestType {
    case getTransformers
    case removeTransformer
    case addTransformer
}

struct RemoveTransformerResponse: Decodable {
    var value: String
}

private enum Paths: String {
    case allsparkPath = "/allspark"
    case transformerPath = "/transformers"
    
    func path() -> URL {
        var url = URL(string: "https://transformers-api.firebaseapp.com")!
        switch self {
        case .allsparkPath:
            url.appendPathComponent(Paths.allsparkPath.rawValue)
            return url
        case .transformerPath:
            url.appendPathComponent(Paths.transformerPath.rawValue)
            return url
        }
    }
}

class RequestManager {
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    var hasToken: Bool {
        return KeychainWrapper.standard.string(forKey: "JWT") != nil
    }
    
    private func token() -> String? {
        guard let jwt = KeychainWrapper.standard.string(forKey: "JWT") else {
            return nil
        }
        return jwt
    }
    
    private func createURLRequest(type: RequestType,
                                  transformerID: String = "",
                                  newTransformer: TransformerToCreate? = nil) -> URLRequest {
        var urlRequest = URLRequest(url: Paths.transformerPath.path())
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token()!)", forHTTPHeaderField: "Authorization") //TODO: change the implementation of token
        
        switch type {
        case .getTransformers:
            urlRequest.httpMethod = "GET"
            return urlRequest
        case .removeTransformer:
            urlRequest.httpMethod = "DELETE"
            urlRequest.url?.appendPathComponent(transformerID)
            return urlRequest
        case .addTransformer:
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try! JSONEncoder().encode(newTransformer)
            return urlRequest
        }
    }
}

extension RequestManager {
    func getToken(completionHandler: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: Paths.allsparkPath.path(), completionHandler: { data, response, error in
            guard let data = data else {
                completionHandler(false)
                return
            }
            guard let jwtString = String(data: data, encoding: .utf8) else { return }
            KeychainWrapper.standard.set(jwtString, forKey: "JWT") //TODO: Validate that the key was saved correctly
            completionHandler(true)
            print(jwtString)
        }).resume()
    }
}
    
extension RequestManager {
    func getTransformers() -> AnyPublisher<Response<Transformers>, Error> {
        return APIClient().run(createURLRequest(type: .getTransformers))
    }
    
    func removeTransformer(with transformerID: String) -> AnyPublisher<Void, Error>  {
        let urlRequest = createURLRequest(type: .removeTransformer, transformerID: transformerID)
        return APIClient().run(urlRequest)
    }
    
    func addTransformer(_ transformer: TransformerToCreate) -> AnyPublisher<Response<Transformer>, Error>   {
        let urlRequest = createURLRequest(type: .addTransformer, newTransformer: transformer)
        return APIClient().run(urlRequest)
    }
}

