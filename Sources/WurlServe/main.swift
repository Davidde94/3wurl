//
//  File.swift
//  
//
//  Created by David Evans on 10/03/2020.
//

import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }

app.get("") { (request: Request) in
    request.view.render("index.leaf")
}

app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

try app.run()
