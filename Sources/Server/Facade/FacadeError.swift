//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation
import Kitura

struct FacadeError: Error {
    let statusCode: HTTPStatusCode
    let message: String
}
