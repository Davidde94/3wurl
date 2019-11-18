//
//  File.swift
//  
//
//  Created by David Evans on 23/09/2019.
//

import Foundation
import SwiftKuery

class IdentifierTable: Table {
    
    let tableName = "identifier"
    
    let id = Column("id")
    let identifier = Column("identifier")
    let target = Column("target")
    let visits = Column("visits")
    
}
