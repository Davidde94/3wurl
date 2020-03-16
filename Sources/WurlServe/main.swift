//
//  File.swift
//  
//
//  Created by David Evans on 10/03/2020.
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
    var baseTarget: URL
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

app.get("") { (request: Request) in
    request.view.render("index.leaf")
}

struct CreateWurlRequest: Decodable {
    var url: URL
}

struct CreateWurlResponse: ResponseEncodable {
    
    func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        let response = Response()
        try! response.content.encode(["url":url], as: .json)
        return response.encodeResponse(status: .created, headers: HTTPHeaders([]), for: request)
    }
    
    var url: URL
}

app.on(.POST, "create", body: .collect(maxSize: 256)) { (request: Request) -> EventLoopFuture<CreateWurlResponse> in
    guard let data = request.body.data else {
        throw Abort(.badRequest, reason: "Missing JSON payload", suggestedFixes: ["Make sure to send a valid JSON-encoded payload"])
    }
    let decoded = try! JSONDecoder().decode(CreateWurlRequest.self, from: data)
    return BanterIdentifierManager.createIdentifier(for: decoded.url, on: request.db).map { wurl in
        return CreateWurlResponse(url: config.baseTarget.appendingPathComponent(wurl.identifier))
    }
}

app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

app.server.configuration.port = config.port

try app.run()
