//
//  MPFatalErrorTestCaseTests.swift
//  MPFatalErrorTestCaseTests
//
//  Created by Manish on 17/6/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import XCTest
@testable import MPFatalErrorTestCase

class MPFatalErrorTestCaseTests: XCTestCase {
    let viewModel = ViewModel()
    
    var url = URL(string: "http://www.thisismylink.com/postName.php")!
    let parameters: [String: Any] = [
        "id": 13,
        "name": "Jack & Jill"
    ]

    func testExample() throws {
        expectFatalError(expectedMessage: "Failed") {
            self.viewModel.testFatal()
        }
    }
    func testPostMethod() throws {
        expectFatalError(expectedMessage: "Failed", timeout: 4) {
           // self.url = URL(string:"https://sampleurl/test")!
            self.viewModel.postMethod(url: self.url, params: self.parameters)
        }
    }
}
