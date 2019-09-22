//
//  Configuration.swift
//  Database
//
//  Created by David Evans on 29/08/2019.
//

import Foundation

struct Configuration: Codable {
    let host: String
    let user: String
    let password: String
    let database: String
    let port: Int
}
