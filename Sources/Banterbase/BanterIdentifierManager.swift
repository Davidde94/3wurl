//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation
import SwiftKuery
import SwiftKueryMySQL

public class BanterIdentifierManager {
    
    public init() {
        
    }
    
    public func createIdentifier(for url: URL, onComplete: @escaping (Result<String, Error>) -> Void) throws {
        
        Database.getConnection { result in
            
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let connection):
                self.createIdentifier(for: url, using: connection, onComplete: onComplete)
            }
            
        }
        
    }
    
    func createIdentifier(for url: URL, using connection: Connection, onComplete: @escaping (Result<String, Error>) -> Void) {
        
        let identifier = BanterIdentifierProvider.new()
        let table = IdentifierTable()
        let query = Insert(
            into: table,
            columns: [
                table.identifier,
                table.target
            ],
            values: [
                identifier,
                url.absoluteString
            ]
        )
        
        connection.execute(query: query) { result in
            
            switch result {
            case .error(let error):
                onComplete(.failure(error))
            case .successNoData, .success(_):
                onComplete(.success(identifier))
            default:
                break
            }
            
        }
        
    }
    
    public func validateIdentifier(_ identifier: String, onComplete: @escaping (Result<String, Error>) -> Void) {
        
        Database.getConnection { result in
            
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let connection):
                self.validateIdentifier(identifier, using: connection, onComplete: onComplete)
            }
            
        }
        
        
    }
    
    func validateIdentifier(_ identifier: String, using connection: Connection, onComplete: @escaping (Result<String, Error>) -> Void) {
        
        let table = IdentifierTable()
        let query = Select(table.target, from: table).where(table.identifier == identifier).limit(to: 1)
        
        connection.execute(query: query) { result in
            
            switch result {
            
            case .error(let error):
                onComplete(.failure(error))
            case .resultSet(let set):
                set.nextRow { row, error in
                    guard let target = row?.first as? String else {
                        return
                    }
                    onComplete(.success(target))
                }
            case .success(_):
                break
            case .successNoData:
                break
            }
            
        }
        
    }
    
    public func registerVisit(_ identifier: String) {
        
        Database.getConnection { result in
            
            switch result {
            case .failure(_):
                break
            case .success(let connection):
                self.registerVisit(identifier, using: connection)
            }
            
        }
        
    }
    
    func registerVisit(_ identifier: String, using connection: Connection) {
        
        let idTable = IdentifierTable()
        let visitTable = VisitTable()
        let select = Select(idTable.id.as("identifier"), now().as("date"), from: idTable).where(idTable.identifier == identifier)
        let insert = Insert(into: visitTable, columns: [visitTable.identifier, visitTable.date], select, returnID: false)
        
        connection.execute(query: insert) { result in
            return
        }
        
    }
    
}
