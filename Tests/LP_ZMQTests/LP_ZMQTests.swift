import XCTest
@testable import LP_ZMQ

final class LP_ZMQTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LP_ZMQ().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
