//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation
import Kitura

public struct Route<T> {
    public let method: RouterMethod
    public let url: String
    public let function: (RouterRequest, @escaping FacadeRouteCallback<T>) throws -> ()
    
    public init(_ method: RouterMethod, url: String, function: @escaping (RouterRequest, @escaping FacadeRouteCallback<T>) throws -> ()) {
        self.method = method
        self.url = url
        self.function = function
    }
}
