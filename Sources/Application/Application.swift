import Foundation
import Kitura
import LoggerAPI
import Configuration
import SwiftMetrics
import SwiftMetricsDash
import CouchDB
import SwiftRedis
import BluemixObjectStorage
import Credentials
import BluemixAppID

public let router = Router()
public let manager = ConfigurationManager()
public var port: Int = 8080

internal var couchDBClient: CouchDBClient?
internal var redis: Redis?
internal var objectStorage: ObjectStorage?
internal var kituraCredentials: Credentials?
internal var webappKituraCredentialsPlugin: WebAppKituraCredentialsPlugin?

public func initialize() throws {

    manager.load(file: "config.json", relativeFrom: .project)
           .load(.environmentVariables)

    port = manager["port"] as? Int ?? port

    let sm = try SwiftMetrics()
    let _ = try SwiftMetricsDash(swiftMetricsInstance : sm, endpoint: router)

    let cloudantConfig = CloudantConfig(manager: manager)

    let couchDBConnProps = ConnectionProperties(host:     cloudantConfig.host,
                                                port:     cloudantConfig.port,
                                                secured:  cloudantConfig.secured,
                                                username: cloudantConfig.username,
                                                password: cloudantConfig.password )

    couchDBClient = CouchDBClient(connectionProperties: couchDBConnProps)

    let redisConfig = RedisConfig(manager: manager)

    redis = Redis()



    router.all("/*", middleware: BodyParser())
    router.all("/", middleware: StaticFileServer())
    initializeSwaggerRoute(path: ConfigurationManager.BasePath.project.path + "/definitions/gyui.yaml")
    initializeProductRoutes()
}

public func run() throws {
    Kitura.addHTTPServer(onPort: port, with: router)
    Kitura.run()
}
