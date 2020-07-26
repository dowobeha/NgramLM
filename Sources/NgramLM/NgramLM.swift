public struct NgramLM {
    
    let counts: Counts
    
    public init(_ counts: Counts) {
        self.counts = counts
    }

    public func callAsFunction(_ line: Line, addTags: Bool) -> Weight {
        
        let tokens: Tokens = self.counts.tokenize(line, addTags: addTags)
        print(tokens)
        let ngramOrder: NgramOrder = self.counts.maxOrder
        
        if tokens.count >= 1 {
            var result = Weight(1.0)
            
            for start in 0...max(0, tokens.count - ngramOrder) {
                let end = min(tokens.count, start + ngramOrder)
                let ngram: Ngram = Ngram(tokens[start..<end])
                let numerator = self.counts(ngram)
                let denominator = self.counts.sumOverContext(NgramContext(tokens[start..<end-1]))
                let ngramProbability = numerator / denominator
                result *= ngramProbability
            }
            
            return result
        } else {
            return 0.0
        }
        
    }
    
}
