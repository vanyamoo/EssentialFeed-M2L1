//
//  RemoteFeedloaderTests.swift
//  EssentialFeedTests
//
//  Created by Vanya Mutafchieva on 13/12/2024.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
}

class HTTPClient {
    static  let shared = HTTPClient()
    
    private init() {
        
    }
    
    var requestedURL: URL?
}

final class RemoteFeedloaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        //let client = HTTPClient()
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()  // sut - system under test
        
//        sut.load()
//        XCTAssert(client.requestedURL)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        //let client = HTTPClient()
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }

}
