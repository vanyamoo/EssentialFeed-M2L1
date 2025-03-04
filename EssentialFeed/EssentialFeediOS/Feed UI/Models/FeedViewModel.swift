//
//  FeedViewModel.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 03/03/2025.
//

import Foundation
import EssentialFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onLoadingStateChange: Observer<Bool>?  // ((Bool) -> Void)?
    var onFeedLoad: Observer<[FeedImage]>? // (([FeedImage]) -> Void)?
    
    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
