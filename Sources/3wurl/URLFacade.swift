//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Foundation
import Kitura
import WurlStore
import Jupiter

struct CreateURL: Decodable {
    let url: URL
}

struct CreateURLResponse: Encodable {
    let url: URL
}

class URLFacade: Facade {
    
    let identifierProvider = BanterIdentifierManager()
    
    func handleCreateRoute(request: RouterRequest, onComplete: @escaping FacadeRouteCallback<CreateURLResponse>) throws {
        
        let body = try request.read(as: CreateURL.self)
        
        try identifierProvider.createIdentifier(for: body.url) { result in
            
            switch result {
            case .failure(let error):
                onComplete(.failure(FacadeError(statusCode: .internalServerError, message: error.localizedDescription)))
            case .success(let identifier):
                
                var responseUrlString = "https://3wurl.xyz"
                if let port = request.parsedURL.port {
                    responseUrlString += ":\(port)"
                }
                let responseURL = URL(string: responseUrlString)!
                    .appendingPathComponent(identifier, isDirectory: false)
                let response = CreateURLResponse(url: responseURL)
                onComplete(.success(FacadeSuccess(statusCode: .OK, response: response)))
            }
            
        }
        
        
    }
    
    func handleRedirect(request: RouterRequest, onComplete: @escaping FacadeRouteCallback<CreateURLResponse>) throws {
     
        let path = request.parsedURL.path!.dropFirst().split(separator: "-")
        let w1 = path[0]
        let w2 = path[1]
        let w3 = path[2]
        let identifier = "\(w1)-\(w2)-\(w3)"
        
        identifierProvider.validateIdentifier(identifier) { result in
            
            switch result {
            case .success(let url):
                let response = CreateURLResponse(url: URL(string: url)!)
                onComplete(.success(FacadeSuccess(statusCode: .movedTemporarily, response: response, headers: ["Location" : url])))
                self.identifierProvider.registerVisit(identifier)
            case .failure(let error):
                onComplete(.failure(FacadeError(statusCode: .internalServerError, message: error.localizedDescription)))
            }
            
        }
        
    }
    
}
