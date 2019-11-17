//
//  File.swift
//  
//
//  Created by David Evans on 12/11/2019.
//

import LoggerAPI

public struct CoreConfiguration {
    let logLevel: LoggerMessageType
    let listenerPorts: ListenerPorts

    public init(logLevel: LoggerMessageType, listenerPorts: ListenerPorts) {
        self.logLevel = logLevel
        self.listenerPorts = listenerPorts
    }
}
