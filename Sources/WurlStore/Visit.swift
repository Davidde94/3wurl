//
//  File.swift
//  
//
//  Created by David Evans on 18/03/2020.
//

import Foundation
import FluentMySQLDriver
import Vapor

final public class Visit: Model, Content {
    
    public typealias IDValue = Int

    public static let schema = "visit"
    
    @ID(custom: "id")           public var id: IDValue?
    @Field(key: "date")         public var date: Date
    @Parent(key: "identifier")  public var wurl: Wurl

    public init() {
        
    }
    
    public init(identifier: Int, date: Date) {
        self.date = date
        self.$wurl.id = identifier
    }
}
