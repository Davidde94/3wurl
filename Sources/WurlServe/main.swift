//
//  File.swift
//  
//
//  Created by David Evans on 10/03/2020.
//

import Vapor
import WurlStore
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

//let configURL = Bundle.module.resourceURL!.appendingPathComponent("host.json")
//let configData = try Data(contentsOf: configURL)
//let config = try JSONDecoder().decode(Configuration.self, from: configData)
//
//app.views.use { (application) -> (ViewRenderer) in
//    application.leaf.renderer
//}
//
//app.get("") { (request: Request) in
//    request.view.render("index.leaf", ["apiTarget" : "\"\(config.apiTarget)/create\""])
//}
//
//app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
//
do {
    try app.run()
} catch {
    print("\(error)")
}
