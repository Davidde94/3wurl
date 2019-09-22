
import Server
import Jupiter

let ports = ListenerPorts.FastCGI(9987)
let config = CoreConfiguration(logLevel: .verbose, listenerPorts: ports)
let server = BanterServer()
server.setup(configuration: config)
server.run()
