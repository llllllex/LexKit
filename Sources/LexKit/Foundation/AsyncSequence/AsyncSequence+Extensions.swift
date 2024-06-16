//
//  AsyncSequence+Extensions.swift
//  
//
//  Created by Lex on 6/17/24.
//

import Foundation


public extension AsyncSequence {
    
    func print() -> AsyncSideEffectSequence<Self> {
        AsyncSideEffectSequence(base: self) { element in
            Swift.print("\(String(describing: self)) get new value: \(element)")
        }
    }
}
