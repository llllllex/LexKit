//
//  String+Extensions.swift
//
//
//  Created by Lex on 6/11/24.
//

import Foundation

public extension String {
    
    /// whether self is a valid string
    var isValid: Bool {
        self.count > 0
    }
    
    /// whether self is a valid URI string
    var isValidURI: Bool {
        if !self.isValid { return false }
        
        return self.isValidURL || self.isValidRemoteFile
    }
    
    /// whether self is a valid URL
    var isValidURL: Bool {
        if !self.isValid { return false }
        
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            
            if self.components(separatedBy: ".").count >= 2 {
                return true
            } else {
                return false
            }
        } else {
            
            return false
        }
    }
    
    /// wether string is a valid remote file
    var isValidRemoteFile: Bool {
        if !self.isValid { return false }
        
        if self.hasPrefix("ftp://") || self.hasPrefix("smb://") {
            
            if self.dropFirst(6).count > 0 {
                return true
            } else {
                return false
            }
        } else {
            
            return false
        }
    }
}

public extension Optional where Wrapped == String {
    
    /// whether self is a valid string
    var isValid: Bool {
        
        guard let self else {
            return false
        }
        
        return self.count > 0
    }
    
    /// whether self is a valid URI string
    var isValidURI: Bool {
        
        guard let self else {
            return false
        }
        
        if !self.isValid { return false }
        
        return self.isValidURL || self.isValidRemoteFile
    }
    
    /// whether self is a valid URL
    var isValidURL: Bool {
        
        guard let self else {
            return false
        }
        
        if !self.isValid { return false }
        
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            
            if self.components(separatedBy: ".").count >= 2 {
                return true
            } else {
                return false
            }
        } else {
            
            return false
        }
    }
    
    /// whether self is a valid remote file
    var isValidRemoteFile: Bool {
        
        guard let self else {
            return false
        }
        
        if !self.isValid { return false }
        
        if self.hasPrefix("ftp://") || self.hasPrefix("smb://") {
            
            if self.dropFirst(6).count > 0 {
                return true
            } else {
                return false
            }
        } else {
            
            return false
        }
    }
}
