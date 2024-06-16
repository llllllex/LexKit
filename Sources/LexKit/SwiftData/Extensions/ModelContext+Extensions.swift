//
//  ModelContext+Extensions.swift
//
//
//  Created by Lex on 6/11/24.
//

import Foundation
import SwiftData

public extension ModelContext {
    
    func exist<T>(modelID: PersistentIdentifier) throws -> T? where T: PersistentModel {
        
        if let reg: T = registeredModel(for: modelID) { return reg }
        
        let fetchDescriptor = FetchDescriptor<T>(
            predicate: #Predicate {
                $0.persistentModelID == modelID
            })
        return try fetch(fetchDescriptor).first
    }
}
