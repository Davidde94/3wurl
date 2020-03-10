//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation
import Wordset
import MySQLKit
import MySQLNIO

public class BanterIdentifierManager {
    
    let database: Database
    
    public init(database: Database) {
        self.database = database
    }
    
    public func createIdentifier(for url: URL, onComplete: @escaping (Result<String, Error>) -> Void) throws {
        self.database.getConnection().whenComplete { (result) in
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let connection):
                self.createIdentifier(for: url, using: connection, onComplete: onComplete)
            }
        }
    }
    
    func createIdentifier(for url: URL, using connection: MySQLConnection, onComplete: @escaping (Result<String, Error>) -> Void) {
        let identifier = WurlGenerator.new
        connection.query("INSERT INTO identifier (identifier, target) VALUES (?, ?)", [
            .init(string: identifier),
            .init(string: url.absoluteString)
        ]).whenComplete { result in
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(_):
                onComplete(.success(identifier))
            }
        }
        
    }
    
    public func validateIdentifier(_ identifier: String, onComplete: @escaping (Result<String, Error>) -> Void) {
        self.database.getConnection().whenComplete { result in
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let connection):
                self.validateIdentifier(identifier, using: connection, onComplete: onComplete)
            }
        }
    }
    
    func validateIdentifier(_ identifier: String, using connection: MySQLConnection, onComplete: @escaping (Result<String, Error>) -> Void) {
        
        let query = "SELECT `target` FROM `identifier` WHERE `identifier`=? LIMIT 1"
        connection.query(query, [.init(string: identifier)]).whenComplete { (result) in
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let rows):
                guard let row = rows.first else {
                    return
                }
                do {
                    onComplete(.success(try row.decode(column: "target", as: String.self)))
                } catch {
                    onComplete(.failure(error))
                }
            }
        }
        
    }
    
    public func registerVisit(_ identifier: String) {
        self.database.getConnection().whenComplete { result in
            switch result {
            case .failure(_):
                break
            case .success(let connection):
                self.registerVisit(identifier, using: connection)
            }
        }
    }
    
    func registerVisit(_ identifier: String, using connection: MySQLConnection) {
        let query = "INSERT INTO `visit` (`identifier`, `date`) SELECT `id` AS identifier now() as date FROM `identifier` WHERE `identifier`.`identifier`=?"
        connection.query(query, [.init(string: identifier)]).whenSuccess { _ in
            return
        }
    }
    
}

// MARK: - Top identifiers
public extension BanterIdentifierManager {
    
    struct TopIdentifier {
        let identifier: String
        let viewCount: Int64
    }
    
    func loadTopIdentifiers(limit: Int = 10, onComplete: @escaping (Result<[TopIdentifier], Error>) -> Void) {
        self.database.getConnection().whenComplete { result in
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let connection):
                self.loadTopIdentifiers(limit: limit, using: connection, onComplete: onComplete)
            }
        }
    }
    
    private func loadTopIdentifiers(limit: Int, using connection: MySQLConnection, onComplete: @escaping (Result<[TopIdentifier], Error>) -> Void) {
        
//        let identifierTable = IdentifierTable()
//        let visitsTable = VisitTable()
//
//        let query = Select(count(visitsTable.identifier).as("count"), identifierTable.identifier, from: visitsTable)
//            .join(identifierTable)
//            .on(visitsTable.identifier == identifierTable.id)
//            .group(by: visitsTable.identifier)
//            .order(by: [.DESC(count(visitsTable.identifier))])
//            .limit(to: limit)
//
//        connection.execute(query: query) { result in
//
//            switch result {
//            case .error(let error):
//                onComplete(.failure(error))
//            case .resultSet(_):
//                result.asRows { rows, error in
//                    guard let rows = rows else {
//                        return
//                    }
//                    let identifiers: [TopIdentifier] = rows.compactMap { row in
//                        guard
//                            let identifier = row["identifier"] as? String,
//                            let viewCount = row["count"] as? Int64
//                        else {
//                            return nil
//                        }
//                        return TopIdentifier(identifier: identifier, viewCount: viewCount)
//                    }
//                    onComplete(.success(identifiers))
//                }
//            default:
//                break
//            }
//
//        }
        
    }
    
}
