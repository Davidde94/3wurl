//
//  File.swift
//  
//
//  Created by David Evans on 26/11/2019.
//

import Kitura
import Jupiter
import WurlStore

class RedirectServer: Server {
    
    let identifierProvider = BanterIdentifierManager()
    
    override func setupRoutes() {
        super.setupRoutes()
        
        router.get(Routes.visit) { (request, response, next) in
            
            let path = request.parsedURL.path!.dropFirst()
            let identifier = String(path)
            
            self.identifierProvider.validateIdentifier(identifier) { result in
                
                switch result {
                case .success(let url):
                    print("yay")
                case .failure(let error):
                    print("nay")
                }
                
            }
            
            next()
        }
        
    }
    
}
