//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Foundation
import MySQLKit

public class Database {
    
    private static let rawConfiguration: Configuration = {
        do {
            let file = #file
            let url = URL(fileURLWithPath: file)
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Configuration")
                .appendingPathComponent("database.json")
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Configuration.self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    private static let configuration = MySQLConfiguration(
        hostname: rawConfiguration.host,
        port: rawConfiguration.port,
        username: rawConfiguration.user,
        password: rawConfiguration.password,
        database: rawConfiguration.database
    )
    
    private static let connectionPool = MySQLConnectionSource(configuration: configuration)
    private static let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    private static let logger = Logger(label: "xyz.3wurl.WurlStore")
    
    public static func getConnection() -> EventLoopFuture<MySQLConnection> {
        return connectionPool.makeConnection(logger: logger, on: eventLoopGroup.next())
    }
    
}
