//
//  GatherQRUITests.swift
//  GatherQRUITests
//
//  Created by K.Hatano on 2021/05/08.
//

import XCTest
import GatherQR

class GatherQRUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let addButton = app.buttons["qrcodelist_add_button"]
        addButton.tap()
        
        _ = app.waitForExistence(timeout: 0.5)
        app.otherElements["scanqrcodeview_"].tap()
        
        _ = app.waitForExistence(timeout: 0.5)
        let titleTextField = app.textFields.matching(identifier: "registerqrcodeview_title_text_field").firstMatch
        let registerButton = app.buttons["registerqrcodeview_register_button"]
        
        titleTextField.tap()
        titleTextField.typeText("UITestTitle")
        app.buttons["Return"].tap()
        // Simulatorだと10秒待たないと、登録ボタンが有効にならない
        sleep(11)
        _ = app.waitForExistence(timeout: 0.5)

        registerButton.tap()
        
        // 戻るボタンを押してTop画面に戻る
        _ = app.waitForExistence(timeout: 0.5)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        //　追加したModelが新しく追加されていること
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
