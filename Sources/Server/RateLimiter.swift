//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation
import Kitura

class RateLimiter: RouterMiddleware {
    
    let semaphore = DispatchSemaphore(value: 25)
    
    func handle(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        
        _ = semaphore.wait(timeout: .now() + .seconds(2))
        next()
        semaphore.signal()
        
    }
    
}
