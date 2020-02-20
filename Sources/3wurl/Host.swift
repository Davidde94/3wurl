//
//  Host.swift
//  
//
//  Created by David Evans on 20/02/2020.
//

import Foundation

struct Host: Codable {
    let host: String
    let port: Int?
    
    static var current: Host = {
        do {
            let file = #file
            let url = URL(fileURLWithPath: file)
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Configuration")
                .appendingPathComponent("host.json")
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Host.self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
}
