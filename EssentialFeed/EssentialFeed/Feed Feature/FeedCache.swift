//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 04/04/2025.
//

import Foundation

public protocol FeedCache {
	typealias Result = Swift.Result<Void, Error>

	func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
