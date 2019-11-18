//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import Foundation

public enum ListenerPorts {
    case HTTP(Int)
    case FastCGI(Int)
    case All(http: Int, fastCGI: Int)
}
