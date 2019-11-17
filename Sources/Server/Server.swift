//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation
import Kitura

public class Server {
    
    let router = Router()
    
    func setup(configuration: CoreConfiguration) {
        
        switch configuration.listenerPorts {
        case .All(http: let http, fastCGI: let fastCGI): break
        case .HTTP(let port): break
        case .FastCGI(let port): break
        }
        
    }
    
    func registerRoute<T>(_ route: Route<T>) {
        switch route.method {
            
        }
    }
    
    public final func run() {
        Kitura.run()
    }
    
}
