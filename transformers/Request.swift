//
//  Request.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-22.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

enum RequestType {
    case getTransformers
    case removeTransformer
    case addTransformer
    case updateTransformer
}

class RequestManager {
    private let baseURLString = "https://transformers-api.firebaseapp.com"
    private let allsparkPath = "/allspark"
    private let transformerPath = "/transformers"
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    typealias CompletionHandlerWithTransformers = (_ transformers:[Transformer]?) -> Void
    typealias CompletionHandlerWithTransformer = (_ transformer:Transformer?) -> Void
    
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
        guard let token = token() else {
                print("Invalid base URL or missing token")
                return nil
        }
        url.appendPathComponent(transformerPath)
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        switch type {
        case .getTransformers:
            urlRequest.httpMethod = "GET"
            return urlRequest
        case .removeTransformer:
            urlRequest.httpMethod = "DELETE"
            guard !transformerID.isEmpty else {
                print("No transformerID")
                return nil
            }
            urlRequest.url?.appendPathComponent(transformerID)
            return urlRequest
        case .addTransformer:
            urlRequest.httpMethod = "POST"
            guard newTransformer != nil else {
                print("No newTransformer")
                return nil
            }
            urlRequest.httpBody = try! JSONEncoder().encode(newTransformer)
            return urlRequest
        case .updateTransformer:
            urlRequest.httpMethod = "PUT"
            guard newTransformer != nil else {
                print("No newTransformer")
                return nil
            }
            urlRequest.httpBody = try! JSONEncoder().encode(newTransformer)
            return urlRequest
        }
    }
}

extension RequestManager {
    func getToken(completionHandler: @escaping CompletionHandler) {
        guard var url = URL(string: baseURLString) else {
            print("Invalid base URL")
            completionHandler(false)
            return
        }
        url.appendPathComponent(allsparkPath)
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {
                print("no data")
                guard let error = error else {
                    print("no error")
                    completionHandler(false)
                    return
                }
                completionHandler(false)
                print(error)
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
    func getTransformers(completionHandler: @escaping CompletionHandlerWithTransformers) {
        guard let urlRequest = createURLRequest(type: .getTransformers) else {
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                print("no data")
                guard let error = error else {
                    print("no error")
                    completionHandler(nil)
                    return
                }
                completionHandler(nil)
                print(error)
                return
            }
            guard let transformers = try? JSONDecoder().decode(Transformers.self, from: data) else {
                print("Error: Couldn't decode data into Transformers")
                return
            }
            completionHandler(transformers.transformers)
        }).resume()
    }
    
    func removeTransformer(transformerID: String,
                           completionHandler: @escaping CompletionHandler) {
        guard let urlRequest = createURLRequest(type: .removeTransformer, transformerID: transformerID) else {
            completionHandler(false)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let _ = response else {
                print("no response")
                guard let error = error else {
                    print("no error")
                    completionHandler(false)
                    return
                }
                completionHandler(false)
                print(error)
                return
            }
            completionHandler(true)
        }).resume()
    }
    
    func addTransformer(transformer: TransformerToCreate,
                        completionHandler: @escaping CompletionHandlerWithTransformer) {
        guard let urlRequest = createURLRequest(type: .addTransformer, newTransformer: transformer) else {
                completionHandler(nil)
                return
        }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                print("no data")
                guard let error = error else {
                    print("no error")
                    completionHandler(nil)
                    return
                }
                completionHandler(nil)
                print(error)
                return
            }
            guard let transformer = try? JSONDecoder().decode(Transformer.self, from: data) else {
                print("Error: Couldn't decode data into Transformers")
                completionHandler(nil)
                return
            }
            completionHandler(transformer)
        }).resume()
    }
    
    func updateTransformer(transformer: TransformerToCreate) {
        guard let urlRequest = createURLRequest(type: .updateTransformer, newTransformer: transformer) else { return }
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                print("no data")
                guard let error = error else {
                    print("no error")
                    return
                }
                print(error)
                return
            }
            guard let transformer = try? JSONDecoder().decode(Transformer.self, from: data) else {
                print("Error: Couldn't decode data into Transformers")
                return
            }
            print(transformer)
        }).resume()
    }
}

