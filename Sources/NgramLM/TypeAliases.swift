public typealias Line = String
public typealias Token = String
public typealias Tokens = [Token]
public typealias Ngram = [Token]
public typealias NgramContext = [Token]
public typealias Weight = Float
public typealias NgramOrder = Int

public typealias TokenDictionary = [Token: Weight]
public typealias ContextDictionary = [NgramContext: TokenDictionary]
public typealias OrderDictionary = [NgramOrder: ContextDictionary]
