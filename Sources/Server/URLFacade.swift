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
        
        let banterIdentifier = try identifierProvider.createIdentifier(for: body.url)
        let responseURL = URL(string: "https://banterurl.blackpoint.co/r")!
            .appendingPathComponent(banterIdentifier, isDirectory: true)
        let response = CreateURLResponse(url: responseURL)
        onComplete(.success(FacadeSuccess(statusCode: .OK, response: response)))
        
        
    }
    
}
