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

public enum BanterIdentifierManager {
    
    public static func createIdentifier(for url: URL, using pool: EventLoopGroupConnectionPool<MySQLConnectionSource>) -> EventLoopFuture<PartialWurl> {
        let identifier = WurlGenerator.new
        let wurl = PartialWurl(identifier: identifier, target: url)
        let database = pool.database(logger: Logger.init(label: "test")).sql()
        let result = database.insert(into: "wurl").columns(["identifier", "target"]).values([wurl.identifier, wurl.target]).run().map { wurl }
        return result
    }
    
    public static func validateIdentifier(_ identifier: String, using pool: EventLoopGroupConnectionPool<MySQLConnectionSource>) -> EventLoopFuture<PartialWurl?> {
        let database = pool.database(logger: Logger.init(label: "test")).sql()
        let result = database.select().columns(["identifier", "target"]).from("wurl").where("identifier", .equal, identifier).limit(1).all(decoding: PartialWurl.self).map { $0.first }
        return result
    }

//    public static func registerVisit(for identifier: String, using pool: EventLoopGroupConnectionPool<MySQLConnectionSource>) {
//        _ = Wurl.query(on: database).field(\.$id).filter(\.$identifier, .equal, identifier).first().map { wurl in
//            guard let wurl = wurl else {
//                return
//            }
//            let visit = Visit(identifier: wurl.id!, date: Date())
//            _ = visit.save(on: database)
//        }
//    }
}
