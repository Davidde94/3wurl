//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation

class BanterIdentifierProvider {
    
    static func new() -> String {
        let word1 = BanterWordset.set1.randomElement()!
        let word2 = BanterWordset.set2.randomElement()!
        let word3 = BanterWordset.set3.randomElement()!
        return "\(word1)-\(word2)-\(word3)"
    }
    
}
