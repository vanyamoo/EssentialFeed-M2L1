//
//  RemoteFeedloaderTests.swift
//  EssentialFeedTests
//
//  Created by Vanya Mutafchieva on 13/12/2024.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        //HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
        //HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
        client.get(from: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPClient { // class HTTPClient {
    //static var shared = HTTPClient() // let
    
    //private init() { }
    
    func get(from url: URL)
    //{
        //requestedURL = url
    //}
    
    //var requestedURL: URL?
}

class HTTPClientSpy: HTTPClient {
    func get(from url: URL) { // override func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?
}

final class RemoteFeedloaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        //let client = HTTPClient()
        //let client = HTTPClient.shared
        let client = HTTPClientSpy()
        //HTTPClient.shared = client
        let _ = RemoteFeedLoader(client: client)
        
//        sut.load()
//        XCTAssert(client.requestedURL)
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        //let client = HTTPClient()
        //let client = HTTPClient.shared
        let client = HTTPClientSpy()
        //HTTPClient.shared = client
        let sut = RemoteFeedLoader(client: client) // sut - system under test
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }

}
