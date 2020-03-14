//
//  File.swift
//  
//
//  Created by David Evans on 14/03/2020.
//

import Foundation
import FluentMySQLDriver
import Vapor

final public class Wurl: Model, Content {
    
    public typealias IDValue = Int

    public static let schema = "wurl"
    
    @ID(custom: "id")           public var id: IDValue?
    @Field(key: "identifier")   public var identifier: String
    @Field(key: "target")       public var target: URL
    @Field(key: "date_created") public var dateCreated: Date

    public init() {
        
    }
    
    public init(identifier: String, target: URL, dateCreated: Date) {
        self.identifier = identifier
        self.target = target
        self.dateCreated = dateCreated
    }
}
