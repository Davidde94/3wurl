//
//  File.swift
//  
//
//  Created by David Evans on 22/09/2019.
//

import Foundation
import Jupiter
import Kitura
import Banterbase

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
                
                var responseUrlString = "\(request.parsedURL.schema!)://\(request.parsedURL.host!)"
                if let port = request.parsedURL.port {
                    responseUrlString += ":\(port)"
                }
                responseUrlString += "/r"
                let responseURL = URL(string: responseUrlString)!
                    .appendingPathComponent(identifier, isDirectory: false)
                let response = CreateURLResponse(url: responseURL)
                onComplete(.success(FacadeSuccess(statusCode: .OK, response: response)))
            }
            
        }
        
        
    }
    
    func handleRedirect(request: RouterRequest, onComplete: @escaping FacadeRouteCallback<CreateURLResponse>) throws {
     
        let identifier = request.parameters["identifier"]!
        
        identifierProvider.validateIdentifier(identifier) { result in
            
            switch result {
            case .success(let url):
                let response = CreateURLResponse(url: URL(string: url))
                onComplete(.success(FacadeSuccess(statusCode: .movedPermanently, response: response, headers: ["Location" : url])))
            case .failure(let error):
                onComplete(.failure(FacadeError(statusCode: .internalServerError, message: error.localizedDescription)))
            }
            
        }
        
    }
    
}
