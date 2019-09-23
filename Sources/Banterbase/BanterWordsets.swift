//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation

struct BanterWordset {
    
    static let set1: Set<String> = {
        return loadWords(fileName: "Wordset1.json")
    }()
    
    static let set2: Set<String> = {
        return loadWords(fileName: "Wordset2.json")
    }()
    
    static let set3: Set<String> = {
        return loadWords(fileName: "Wordset3.json")
    }()
    
    private static func loadWords(fileName: String) -> Set<String> {
        do {
            let fileURL = URL(fileURLWithPath: #file)
                .deletingLastPathComponent()
                .appendingPathComponent("Wordsets")
                .appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            let array = try JSONDecoder().decode([String].self, from: data)
            return Set(array)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
