//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation
import Kitura

public struct FacadeError: Error {
    public let statusCode: HTTPStatusCode
    public let message: String
    
    public init(statusCode: HTTPStatusCode, message: String){
        self.statusCode = statusCode
        self.message = message
    }
}
