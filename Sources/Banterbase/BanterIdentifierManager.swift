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
    
}
