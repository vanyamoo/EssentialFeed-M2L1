//
//  SharedTestHelpers.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 04/02/2025.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0 )
}

func anyURL() -> URL {
   return URL(string: "http://any-url.com")!
}
