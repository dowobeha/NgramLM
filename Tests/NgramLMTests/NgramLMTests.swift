import XCTest
@testable import NgramLM

final class NgramLMTests: XCTestCase {
    func testExample() {
        let lines = [WeightedLine(line: "a b c", weight: 1.0),
                     WeightedLine(line: "a c b", weight: 1.0)]
        let corpus = WeightedCorpus(weightedLines: lines)
        let counts = Counts(from: corpus, ngramOrder: 2, tokenize: SplitOnSpace())
        let lm = NgramLM(counts)
        let p = lm("<s> a c b c", addTags: false)
        print(p)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
