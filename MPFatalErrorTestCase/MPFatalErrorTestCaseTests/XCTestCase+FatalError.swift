//
//  XCTestCase+FatalError.swift
//  MPFatalErrorTestCase
//
//  Created by Manish on 17/6/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import Foundation
import MPFatalErrorTestCase
import XCTest

extension XCTestCase {
    
    func expectFatalError(expectedMessage: String, timeout: TimeInterval = 0.1, testcase: @escaping () -> Void) {

        // arrange
        let expectation = self.expectation(description: "expectingFatalError")
        var assertionMessage: String? = nil

        // act, perform on separate thead because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

        // override fatalError. This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }
        
        self.waitForExpectations(timeout: timeout) { _ in
            // assert
            XCTAssertEqual(assertionMessage, expectedMessage)

            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }

    /// This is a `noreturn` function that pauses forever
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
