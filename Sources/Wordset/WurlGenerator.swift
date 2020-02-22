//
//  File.swift
//  
//
//  Created by David Evans on 22/02/2020.
//

public enum WurlGenerator {
    
    public static var new: String {
        return create(wordCount: 3)
    }
    
    public static func create(wordCount: Int) -> String {
        
        // enforce a minimum of 3 words
        let wordCount = max(wordCount, 3)
        let maxLength = wordCount * 7
        var remainingLetters = maxLength
        
        let first = Wordsets.set1.filter { $0.count < remainingLetters}.randomElement()!
        remainingLetters -= first.count
        
        let last = Wordsets.set3.filter { $0.count < remainingLetters}.randomElement()!
        remainingLetters -= last.count
        
        var words = [String]()
        words.append(first)
        for _ in 1...wordCount-2 {
            let word = Wordsets.set2.filter { $0.count <= remainingLetters }.randomElement()
            if let word = word {
                remainingLetters -= words.count
                words.append(word)
            } else {
                break
            }
        }
        words.append(last)
        
        return words.joined(separator: "-")
    }
    
}
