//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation

class BanterIdentifierProvider {
    
    static func new(maxLength: Int = 15) -> String {
        let word1 = BanterWordset.set1.filter{ $0.count < maxLength / 3}.randomElement()!
        let word2 = BanterWordset.set2.filter{ $0.count < maxLength / 3}.randomElement()!
        let word3 = BanterWordset.set3.filter{ $0.count < maxLength / 3}.randomElement()!
        return "\(word1)-\(word2)-\(word3)"
    }
    
}
