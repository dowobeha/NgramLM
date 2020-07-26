import XCTest
@testable import NgramLM

final class NgramLMTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NgramLM().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
