//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Jupiter
import Kitura
import KituraStencil

public class BanterServer: Server {
    
    let urlFacade = URLFacade()
    
    override public func setup(configuration: CoreConfiguration) {
        super.setup(configuration: configuration)
        setupRoutes()
    }
    
}

// MARK: - Routes
extension BanterServer {
    
    func setupRoutes() {
        
        let route = Route(.post, url: BanterRoutes.create, function: urlFacade.handleCreateRoute)
        registerRoute(route)
        
        let visitRoute = Route(.get, url: BanterRoutes.visit, function: urlFacade.handleRedirect)
        registerRoute(visitRoute)
        
        router.add(templateEngine: StencilTemplateEngine())
        router.get("/") { (request, response, next) in
            
            do {
                try response.render("index.stencil", context: [:])
            } catch {
                print(error)
            }
            
            next()
            
        }
    }
    
}
