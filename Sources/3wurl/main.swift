
import Server
import Jupiter

let ports = ListenerPorts.HTTP(9987)
let config = CoreConfiguration(logLevel: .debug, listenerPorts: ports)
let server = WURLServer()
server.run(configuration: config)
