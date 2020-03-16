//
//  File.swift
//  
//
//  Created by David Evans on 16/03/2020.
//

import Vapor
import WurlStore
import Fluent
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

let configURL = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("Configuration", isDirectory: true)
    .appendingPathComponent("host.json")
let configData = try Data(contentsOf: configURL)
let config = try JSONDecoder().decode(Configuration.self, from: configData)

let databaseConfigURL = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("Configuration", isDirectory: true)
    .appendingPathComponent("database.json")
let databaseConfigData = try Data(contentsOf: databaseConfigURL)
let databaseConfig = try JSONDecoder().decode(DatabaseConfiguration.self, from: databaseConfigData)

app.databases.use(.mysql(
    hostname: databaseConfig.host,
    port: databaseConfig.port,
    username: databaseConfig.user,
    password: databaseConfig.password,
    database: databaseConfig.database,
    tlsConfiguration: .forClient(minimumTLSVersion: .tlsv12, certificateVerification: .none)
), as: .mysql)

app.get("*") { (request: Request) -> EventLoopFuture<Response> in
    let identifier = String(request.url.path.dropFirst())
    return BanterIdentifierManager.validateIdentifier(identifier, on: request.db).flatMapResult({ (wurl) -> Result<Response, Error> in
        guard let wurl = wurl  else {
            return .failure(Abort(.notFound))
        }
        return .success(Response(status: .temporaryRedirect, headers: HTTPHeaders([
            ("location", wurl.target.absoluteString)
        ])))
    })
}

app.server.configuration.port = 12345

try app.run()
