import XCTest
@testable import StarChart

final class StarChartTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(StarChart().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
