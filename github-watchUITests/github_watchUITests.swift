//
//  github_watchUITests.swift
//  github-watchUITests
//
//  Created by Ibrahim Berat Kaya on 22.02.2021.
//

import XCTest

class github_watchUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Assumes that the user has already authenticated the GitHub app by signing in once previously.
    func testSignInWithWatchInactive() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments += ["-reset-user"]
        app.launch()
        
        // Click the login button.
        let button = app.buttons["loginButton"]
        XCTAssertTrue(button.exists, "Login button does not exist!")
        button.tap()
        
        // Wait 3 seconds to sign in.
        sleep(3)
        
        // Dismiss alert.
        XCTAssertTrue(app.alerts.count == 1, "An alert was supposed to be displayed!")
        app.buttons["OK!"].tap()
        XCTAssertTrue(app.alerts.count == 0, "An alert was not supposed to be displayed!")
    }
    
    /// Assumes that the user has already authenticated the GitHub app by signing in once previously.
    func testSignInAndSignOutWithWatchInactive() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments += ["-reset-user"]
        app.launch()
        
        // Click the login button.
        let loginButton = app.buttons["loginButton"]
        XCTAssertTrue(loginButton.exists, "Login button does not exist!")
        loginButton.tap()
        
        // Wait 3 seconds to sign in.
        sleep(3)
        
        // Dismiss alert.
        XCTAssertTrue(app.alerts.count == 1, "An alert was supposed to be displayed!")
        app.buttons["OK!"].tap()
        XCTAssertTrue(app.alerts.count == 0, "The alert was supposed to be dismissed!")
        
        // Click the sign out button.
        let signOutButton = app.buttons["signOutButton"]
        XCTAssertTrue(signOutButton.exists, "Sign Out button does not exist!")
        signOutButton.tap()
        
        // The login button should be displayed again.
        XCTAssertTrue(loginButton.exists, "Sign Out button does not exist!")
    }
    
    /// Assumes that the user has already authenticated the GitHub app by signing in once previously.
    /// Test signing in with the Apple Watch active.
    func testSignInWithWatchActive() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments += ["-reset-user"]
        app.launch()
        
        // Click the login button.
        let button = app.buttons["loginButton"]
        XCTAssertTrue(button.exists, "Login button does not exist!")
        button.tap()
        
        // Wait 3 seconds to sign in.
        sleep(3)
        
        // Expect no alert.
        XCTAssertTrue(app.alerts.count == 0, "An alert was not supposed to be displayed")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
