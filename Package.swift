import PackageDescription

let package = Package(
    name: "gyui",
    targets: [
      Target(name: "gyui", dependencies: [ .Target(name: "Application") ])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/CloudConfiguration.git", majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git",  majorVersion: 1),

        .Package(url: "https://github.com/IBM-Swift/Kitura-redis.git", majorVersion: 1),

        .Package(url: "https://github.com/ibm-bluemix-mobile-services/bluemix-objectstorage-serversdk-swift.git", majorVersion: 0, minor: 7),

        .Package(url: "https://github.com/ibm-cloud-security/appid-serversdk-swift.git", majorVersion: 1),

        .Package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", majorVersion: 0, minor: 0),

        

        .Package(url: "https://github.com/IBM-Swift/Kitura.git",                 majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",           majorVersion: 1)
    ],
    exclude: ["src"]
)
