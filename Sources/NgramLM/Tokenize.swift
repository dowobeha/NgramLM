public protocol Tokenize {
    func callAsFunction(_ line: Line, addTags: Bool) -> Tokens
}


public struct SplitOnSpace: Tokenize {
    
    public func callAsFunction(_ line: Line, addTags: Bool = true) -> Tokens {
        if addTags {
            return ["<s>"] + line.split(separator: " ").map{Token($0)} + ["</s>"]
        } else {
            return line.split(separator: " ").map{Token($0)}
        }
    }
    
}
