import XCTest
@testable import NgramLM

final class NgramLMTests: XCTestCase {
    func testExample() {
        let counts = Counts(from: ["a b c", "a c b"], ngramOrder: 2, tokenize: SplitOnSpace())
        let lm = NgramLM(counts)
        let p = lm("<s> a c b c", addTags: false)
        print(p)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
