//
//  AsyncSideEffectSequence.swift
//  
//
//  Created by Lex on 6/17/24.
//

import Foundation

public struct AsyncSideEffectSequence<Base: AsyncSequence>: AsyncSequence {
    
    public typealias Element = Base.Element
    
    private let base: Base
    private let operation: (Element) async -> Void
    
    /// 结束回调
    private let completionCallback: (() -> Void)?
    
    public init(
        base: Base,
        operation: @escaping (Element) async -> Void,
        completionCallback: (() -> Void)? = nil
    ) {
        self.base = base
        self.operation = operation
        self.completionCallback = completionCallback
    }
    
    public struct AsyncIterator: AsyncIteratorProtocol {
        
        private var base: Base.AsyncIterator
        
        private let operation: (Element) async -> Void
        
        private let completionCallback: (() -> Void)?
        
        init(
            base: Base.AsyncIterator,
            operation: @escaping (Element) async -> Void,
            completionCallback: (() -> Void)?
        ) {
            self.base = base
            self.operation = operation
            self.completionCallback = completionCallback
        }
        
        public mutating func next() async throws -> Base.Element? {
            
            let value = try await base.next()
            if let value {
                
                await operation(value)
            } else {
                
                // 当 iterator.next() 返回 nil 时，代表序列结束
                if let completionCallback {
                    completionCallback()
                }
            }
            return value
        }
    }
    
    public func makeAsyncIterator() -> AsyncIterator {
        
        return AsyncIterator(
            base: base.makeAsyncIterator(),
            operation: operation,
            completionCallback:completionCallback
        )
    }
}
