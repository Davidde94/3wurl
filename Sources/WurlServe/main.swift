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
        return CreateWurlResponse(url: URL(string: "https://3wl.uk/\(wurl.identifier)")!)
    }
}

app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

try app.run()
