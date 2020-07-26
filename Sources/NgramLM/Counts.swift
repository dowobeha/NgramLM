
public struct Counts {
    
    let counts: OrderDictionary
    let tokenize: Tokenize
    let maxOrder: NgramOrder
    
    public init(from corpus: WeightedCorpus,
                ngramOrder: NgramOrder,
                tokenize: Tokenize) {
        
        var orderDictionary = OrderDictionary()
        
        for weightedLine in corpus.weightedLines {
            
            let tokens: Tokens = tokenize(weightedLine.line, addTags: true)
            
            var contextLength = ngramOrder - 1
            
            while contextLength >= 0 {
                
                let order = contextLength + 1
                
                for start in 0...(tokens.count - contextLength - 1) {
                    let end = start + contextLength
                    
                    let context: NgramContext = contextLength > 0 ? NgramContext(tokens[start..<end]) : NgramContext([])
                    let token: Token = tokens[end]
                    
                    var contextDictionary = orderDictionary[order, default: ContextDictionary()]
                    var tokenDictionary = contextDictionary[context, default: TokenDictionary()]
                    let previousWeight = tokenDictionary[token, default: Weight(0.0)]
                    let updatedWeight = previousWeight + weightedLine.weight
                    
                    tokenDictionary.updateValue(updatedWeight, forKey: token)
                    contextDictionary.updateValue(tokenDictionary, forKey: context)
                    orderDictionary.updateValue(contextDictionary, forKey: order)
                    
                }
                
                contextLength -= 1
            }
            
        }
        
        self.counts = orderDictionary
        self.tokenize = tokenize
        self.maxOrder = ngramOrder
    }
    
    public func callAsFunction(_ line: Line, addTags: Bool = true) -> Weight {
        return self.callAsFunction(self.tokenize(line, addTags: addTags))
    }
    
    public func callAsFunction(_ ngram: Ngram) -> Weight {
                
        if let contextDictionary = self.counts[ngram.count] {
            
            let end = ngram.count - 1
            
            let context: NgramContext = end > 0 ? NgramContext(ngram[0..<end]) : NgramContext([])
            let token: Token = ngram[end]
            
            if let tokenDictionary = contextDictionary[context] {
                if let weight = tokenDictionary[token] {
                    return weight
                }
            }
        }
        
        return Weight(0.0)
    }
    
    public func sumOverContext(_ context: NgramContext) -> Weight {
    
        if let contextDictionary = self.counts[context.count + 1] {
                        
            if let tokenDictionary = contextDictionary[context] {
                return tokenDictionary.values.reduce(0.0, +)
            }
        }
        
        return Weight(0.0)
        
    }
}
