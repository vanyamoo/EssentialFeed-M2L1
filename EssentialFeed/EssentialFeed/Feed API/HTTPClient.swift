//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 11/01/2025.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
