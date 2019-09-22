//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Jupiter

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
        
    }
    
}
