//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 17/01/2025.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {
        
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: url, completionHandler: { data,response, error in
            if let error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }).resume()
    }
}
