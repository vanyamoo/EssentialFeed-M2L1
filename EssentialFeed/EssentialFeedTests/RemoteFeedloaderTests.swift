//
//  RemoteFeedloaderTests.swift
//  EssentialFeedTests
//
//  Created by Vanya Mutafchieva on 13/12/2024.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

final class RemoteFeedloaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        let sut = RemoteFeedLoader()  // sut - system under test
        
//        sut.load()
//        XCTAssert(client.requestedURL)
        XCTAssertNil(client.requestedURL)
    }

}
