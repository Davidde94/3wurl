//
//  File.swift
//  
//
//  Created by David Evans on 10/03/2020.
//

import Vapor
import WurlStore
import Fluent
import Leaf
import MySQLKit

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }

struct Configuration: Decodable {
    var host: String
    var port: Int
    var apiTarget: URL
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
), as: .mysql, isDefault: true)

app.views.use { (application) -> (ViewRenderer) in
    application.leaf.renderer
}

app.get("") { (request: Request) in
    request.view.render("index.leaf", ["apiTarget" : "\"\(config.apiTarget)/create\""])
}

app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

app.server.configuration.port = config.port

try app.run()
