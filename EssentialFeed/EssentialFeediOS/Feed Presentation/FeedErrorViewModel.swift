//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 27/03/2025.
//

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
