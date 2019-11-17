//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation
import Kitura

struct FacadeSuccess<T> {
    let statusCode: HTTPStatusCode
    let response: T
    let headers: [String: String]
    
    init(statusCode: HTTPStatusCode, response: T, headers: [String: String] = [:]) {
        self.statusCode = statusCode
        self.response = response
        self.headers = headers
    }
}
