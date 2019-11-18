//
//  File.swift
//  
//
//  Created by David Evans on 17/11/2019.
//

import Foundation
import Kitura
import LoggerAPI
import HeliumLogger

open class Server {
    
    final public let router = Router()
    
    public init() {
        
    }
    
    public final func run(configuration: CoreConfiguration) {
        setupRoutes()
        setupRouter(configuration: configuration)
        setupLogging(configuration: configuration)
        Kitura.run(exitOnFailure: true)
    }
    
    open func setupRoutes() {
        
    }
    
    private func setupRouter(configuration: CoreConfiguration) {
        switch configuration.listenerPorts {
            
        case .HTTP(let port):
            setupHTTP(port: port)
        case .FastCGI(let port):
            setupFastCGI(port: port)
        case .All(let http, let fastCGI):
            setupHTTP(port: http)
            setupFastCGI(port: fastCGI)
        }
    }
    
    private func setupLogging(configuration: CoreConfiguration) {
        HeliumLogger.use(configuration.logLevel)
    }
    
    public final func registerRoute<T>(_ route: Route<T>) {
        switch route.method {
        case .get:
            router.get(route.url) { request, response, next in
                self.executeRoute(route, request: request, response: response)
            }
        default:
            break
        }
    }
    
    private func executeRoute<T>(_ route: Route<T>, request: RouterRequest, response: RouterResponse) {
        do {
            try route.function(request, routeCallback)
        } catch {
            Log.error(error.localizedDescription)
        }
    }
    
    private func routeCallback<T>(_ result: Result<FacadeSuccess<T>, FacadeError>) {
        Log.info("Finished request")
    }
    
}

// MARK: - Router setup
extension Server {
    
    func setupHTTP(port: Int) {
        Kitura.addHTTPServer(onPort: port, with: router)
    }

    func setupFastCGI(port: Int) {
        Kitura.addFastCGIServer(onPort: port, with: router)
    }
    
}
