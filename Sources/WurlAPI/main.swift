//
//  File.swift
//
//
//  Created by David Evans on 10/03/2020.
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
    var baseTarget: URL
}

struct DatabaseConfiguration: Decodable {
    var host: String
    var port: Int
    var user: String
    var password: String
    var database: String
}

//let configURL = Bundle.module.resourceURL!.appendingPathComponent("host.json")
//let configData = try Data(contentsOf: configURL)
//let config = try JSONDecoder().decode(Configuration.self, from: configData)
//
//let databaseConfigURL = Bundle.module.resourceURL!.appendingPathComponent("database.json")
//let databaseConfigData = try Data(contentsOf: databaseConfigURL)
//let databaseConfig = try JSONDecoder().decode(DatabaseConfiguration.self, from: databaseConfigData)
//
//let mysqlConfig = MySQLConfiguration(
//                                     hostname: databaseConfig.host,
//                                     port: databaseConfig.port,
//                                     username: databaseConfig.user,
//                                     password: databaseConfig.password,
//                                     database: databaseConfig.database,
//                                     tlsConfiguration: .forClient(minimumTLSVersion: .tlsv12, certificateVerification: .none)
//                                     )
//let dbConnectionPool = EventLoopGroupConnectionPool(source: MySQLConnectionSource(configuration: mysqlConfig), on: app.eventLoopGroup)
//
//struct CreateWurlRequest: Decodable {
//    var url: URL
//}
//
//struct CreateWurlResponse: ResponseEncodable {
//
//    func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
//        let response = Response()
//        try! response.content.encode(["url":url], as: .json)
//        return response.encodeResponse(status: .created, headers: HTTPHeaders([]), for: request)
//    }
//
//    var url: URL
//}
//
//app.on(.POST, "create", body: .collect(maxSize: 256)) { (request: Request) -> EventLoopFuture<CreateWurlResponse> in
//    guard let data = request.body.data else {
//        throw Abort(.badRequest, reason: "Missing JSON payload", suggestedFixes: ["Make sure to send a valid JSON-encoded payload"])
//    }
//
//    do {
//        let decoded = try JSONDecoder().decode(CreateWurlRequest.self, from: data)
//        return BanterIdentifierManager.createIdentifier(for: decoded.url, using: dbConnectionPool).map { wurl in
//            return CreateWurlResponse(url: config.baseTarget.appendingPathComponent(wurl.identifier))
//        }.hop(to: request.eventLoop)
//    } catch let error as DecodingError {
//        throw Abort(.badRequest, reason: "The JSON was invalid: \(error)")
//    } catch {
//        throw Abort(.badRequest, reason: "The data you sent wasn't valid, but we aren't sure why.")
//    }
//}
//
//app.middleware.use(CORSMiddleware(configuration: CORSMiddleware.Configuration(allowedOrigin: .all, allowedMethods: [.POST], allowedHeaders: [.accept, .contentType])))
//
//do {
////    try app.server.start(address: .hostname(config.host, port: config.port))
//    app.http.server.configuration.address = BindAddress.hostname(config.host, port: config.port)
//    try app.run()
//} catch {
//    print("\(error)")
//}
