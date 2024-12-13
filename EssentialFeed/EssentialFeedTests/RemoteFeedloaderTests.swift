//
//  RemoteFeedloaderTests.swift
//  EssentialFeedTests
//
//  Created by Vanya Mutafchieva on 13/12/2024.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        //HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient() // let
    
    //private init() { }
    
    func get(from url: URL) {
//        requestedURL = url
    }
    
    //var requestedURL: URL?
}

class HTTPClientSpy: HTTPClient {
    override func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?
}

final class RemoteFeedloaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        //let client = HTTPClient()
        //let client = HTTPClient.shared
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader()  // sut - system under test
        
//        sut.load()
//        XCTAssert(client.requestedURL)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        //let client = HTTPClient()
        //let client = HTTPClient.shared
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }

}
