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

}
