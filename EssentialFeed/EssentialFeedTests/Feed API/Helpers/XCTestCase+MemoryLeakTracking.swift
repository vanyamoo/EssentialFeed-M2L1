//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 16/01/2025.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak", file: file, line: line)
        }
    }
}


