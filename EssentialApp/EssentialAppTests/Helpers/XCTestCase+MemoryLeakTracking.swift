//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialApp
//
//  Created by Vanya Mutafchieva on 02/04/2025.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
