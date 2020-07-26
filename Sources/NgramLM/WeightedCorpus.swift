public struct WeightedCorpus {
    
    let weightedLines: [WeightedLine]
    
    public init(weightedLines: [WeightedLine]) {
        self.weightedLines = weightedLines
    }
    
}


public struct WeightedLine {
    public let line: Line
    public let weight: Weight
    
    public init(line: Line, weight: Weight) {
        self.line = line
        self.weight = weight
    }
}
