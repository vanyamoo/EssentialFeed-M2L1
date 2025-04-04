//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 04/04/2025.
//

import Foundation

public protocol FeedImageDataCache {
	typealias Result = Swift.Result<Void, Error>

	func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
