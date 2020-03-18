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
import FluentKit

public enum BanterIdentifierManager {
    
    public static func createIdentifier(for url: URL, on database: Database) -> EventLoopFuture<Wurl> {
        let identifier = WurlGenerator.new
        let wurl = Wurl(identifier: identifier, target: url, dateCreated: Date())
        return wurl.save(on: database).map { wurl }
    }
    
    public static func validateIdentifier(_ identifier: String, on database: Database) -> EventLoopFuture<Wurl?> {
        return Wurl.query(on: database).filter(\.$identifier, .equal, identifier).first()
    }
    
    public static func registerVisit(for identifier: String, on database: Database) {
        _ = Wurl.query(on: database).field(\.$id).filter(\.$identifier, .equal, identifier).first().map { wurl in
            guard let wurl = wurl else {
                return
            }
            let visit = Visit(identifier: wurl.id!, date: Date())
            _ = visit.save(on: database)
        }
    }
}
