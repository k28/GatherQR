//
//  ScannerViewModelTests.swift
//  GatherQRTests
//
//  Created by K.Hatano on 2021/12/13.
//

import XCTest
@testable import GatherQR

class ScannerViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init() throws {
        let scaneViewModel = ScannerViewModel()
        XCTAssertEqual(false, scaneViewModel.torchIsOn)
        XCTAssertEqual("", scaneViewModel.lastQRCode)
        XCTAssertEqual(false, scaneViewModel.qrCodeFound)
    }
    
    func test_onFoundQRCode() throws {
        let scaneViewModel = ScannerViewModel()
        scaneViewModel.onFoundQRCode("Hello!")
        XCTAssertEqual("Hello!", scaneViewModel.lastQRCode)
        XCTAssertEqual(true, scaneViewModel.qrCodeFound)
    }

}
