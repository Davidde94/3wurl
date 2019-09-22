//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation

public class BanterIdentifierManager {
    
    public init() {
        
    }
    
    public func createIdentifier(for url: URL) throws -> String {
        
        return BanterIdentifierProvider.new()
        
    }
    
}
