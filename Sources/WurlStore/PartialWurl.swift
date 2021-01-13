//
//  File.swift
//  
//
//  Created by David Evans on 14/03/2020.
//

import Foundation
import MySQLKit
import Vapor

public struct PartialWurl: Content {
    
    public var identifier: String
    public var target: URL
    
    public init(identifier: String, target: URL) {
        self.identifier = identifier
        self.target = target
    }
}
