//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Foundation
import SwiftKuery
import SwiftKueryMySQL

public class Database {
    
    static let connectionOptions = ConnectionPoolOptions(initialCapacity: 1, maxCapacity: 10)
    
    static let configuration: Configuration = {
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
    
    static var connectionPool = MySQLConnection.createPool(
        host: configuration.host,
        user: configuration.user,
        password: configuration.password,
        database: configuration.database,
        poolOptions: connectionOptions
    )
    
    public static func getConnection(onConnection: @escaping (Result<Connection, QueryError>) -> Void) {
        connectionPool.getConnection { connection, error in
            if let error = error {
                onConnection(.failure(error))
            } else if let connection = connection {
                onConnection(.success(connection))
            } else {
                fatalError()
            }
        }
    }
    
}
