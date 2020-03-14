//
//  Configuration.swift
//  Database
//
//  Created by David Evans on 29/08/2019.
//

import Foundation
import MySQLKit

struct DatabaseConfiguration: Codable {
    
    static var `default`: DatabaseConfiguration {
        let file = #file
        let url = URL(fileURLWithPath: file)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Configuration")
            .appendingPathComponent("database.json")
        do {
            return try Self.load(from: url)
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    static func load(from url: URL) throws -> DatabaseConfiguration {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Self.self, from: data)
    }
    
    let host: String
    let user: String
    let password: String
    let database: String
    let port: Int
}

extension MySQLConfiguration {
    
    init(configuration: DatabaseConfiguration) {
        self.init(
            hostname: configuration.host,
            port: configuration.port,
            username: configuration.user,
            password: configuration.password,
            database: configuration.database
        )
    }
    
}
