//
//  File.swift
//  
//
//  Created by David Evans on 16/03/2020.
//

import Vapor
import WurlStore
import MySQLKit

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }

struct Configuration: Decodable {
    var host: String
    var port: Int
}

struct DatabaseConfiguration: Decodable {
    var host: String
    var port: Int
    var user: String
    var password: String
    var database: String
}

let configURL = Bundle.module.resourceURL!.appendingPathComponent("host.json")
let configData = try Data(contentsOf: configURL)
let config = try JSONDecoder().decode(Configuration.self, from: configData)

let databaseConfigURL = Bundle.module.resourceURL!.appendingPathComponent("database.json")
let databaseConfigData = try Data(contentsOf: databaseConfigURL)
let databaseConfig = try JSONDecoder().decode(DatabaseConfiguration.self, from: databaseConfigData)

let mysqlConfig = MySQLConfiguration(
                                     hostname: databaseConfig.host,
                                     port: databaseConfig.port,
                                     username: databaseConfig.user,
                                     password: databaseConfig.password,
                                     database: databaseConfig.database,
                                     tlsConfiguration: .forClient(minimumTLSVersion: .tlsv12, certificateVerification: .none)
                                     )
let dbConnectionPool = EventLoopGroupConnectionPool(source: MySQLConnectionSource(configuration: mysqlConfig), on: app.eventLoopGroup)

app.get("*") { (request: Request) -> EventLoopFuture<Response> in
    let identifier = String(request.url.path.dropFirst())
    return BanterIdentifierManager.validateIdentifier(identifier, using: dbConnectionPool).flatMapResult({ (wurl) -> Result<Response, Error> in
        guard let wurl = wurl  else {
            return .failure(Abort(.notFound))
        }
//        BanterIdentifierManager.registerVisit(for: wurl.identifier, on: request.db)
        return .success(Response(status: .temporaryRedirect, headers: HTTPHeaders([
            ("location", wurl.target.absoluteString)
        ])))
    })
}

do {
//    try app.server.start(address: .hostname(config.host, port: config.port))
    app.http.server.configuration.address = BindAddress.hostname(config.host, port: config.port)
    try app.run()
} catch {
    print("\(error)")
}
