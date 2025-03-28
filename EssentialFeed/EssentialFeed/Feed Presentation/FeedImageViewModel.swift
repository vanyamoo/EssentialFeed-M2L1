//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 28/03/2025.
//

public struct FeedImageViewModel<Image> {
    public let description: String?
    public let location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool

    public var hasLocation: Bool {
        return location != nil
    }
}
