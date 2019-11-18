//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Foundation
import Kitura
import KituraStencil
import WurlStore
import Jupiter

public class WURLServer: Server {
    
    let identifierProvider = BanterIdentifierManager()
    
    let urlFacade = URLFacade()
    let rateLimiter = RateLimiter()
    
    override public func setupRoutes() {
        
        router.all(middleware: rateLimiter)
        
        let route = Route(.post, url: BanterRoutes.create, function: urlFacade.handleCreateRoute)
        registerRoute(route)
        
        let visitRoute = Route(.get, url: BanterRoutes.visit, function: urlFacade.handleRedirect)
        registerRoute(visitRoute)
        
        let staticFileServer = StaticFileServer()
        router.get("/public", allowPartialMatch: true, middleware: staticFileServer)
        
        //        router.viewsPath = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Views").absoluteString
        router.add(templateEngine: StencilTemplateEngine())
        router.get("/") { (request, response, next) in
            
            self.identifierProvider.loadTopIdentifiers { result in
                
                let topIdentifiers: [BanterIdentifierManager.TopIdentifier]
                switch result {
                case .failure(_):
                    topIdentifiers = []
                case .success(let results):
                    topIdentifiers = results
                }
                
                do {
                    try response.render("index.stencil", context: [
                        "topIdentifiers" : topIdentifiers
                    ])
                } catch {
                    print(error)
                }
                
                next()
                
            }
            
        }
    }
    
}
