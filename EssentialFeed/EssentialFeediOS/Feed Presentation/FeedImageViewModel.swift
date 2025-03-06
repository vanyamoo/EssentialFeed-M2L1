//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 04/03/2025.
//

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
