//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation
import Kitura

struct Route<T> {
    let method: RouterMethod
    let url: String
    let function: (RouterRequest, @escaping FacadeRouteCallback<T>) throws -> ()
    
    init(_ method: RouterMethod, url: String, function: @escaping (RouterRequest, @escaping FacadeRouteCallback<T>) throws -> ()) {
        self.method = method
        self.url = url
        self.function = function
    }
}
