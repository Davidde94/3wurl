//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Foundation
import MySQLKit

public class Database {
    
    let configuration: MySQLConfiguration
    private let connectionSource: MySQLConnectionSource
    private let eventLoopGroup: MultiThreadedEventLoopGroup
    private let logger: Logger
    
    public init(configuration: MySQLConfiguration) {
        self.configuration = configuration
        self.connectionSource = MySQLConnectionSource(configuration: configuration)
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        self.logger = Logger(label: "xyz.3wurl.WurlStore")
    }
    
    public func getConnection() -> EventLoopFuture<MySQLConnection> {
        return connectionSource.makeConnection(logger: logger, on: eventLoopGroup.next())
    }
    
}
