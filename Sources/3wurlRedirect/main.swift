//
//  File.swift
//  
//
//  Created by David Evans on 25/11/2019.
//

import Jupiter

let ports = ListenerPorts.HTTP(9986)
let config = CoreConfiguration(logLevel: .debug, listenerPorts: ports)
let server = RedirectServer()
server.run(configuration: config)
