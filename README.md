## Scaffolded Swift Kitura server application

[![Platform](https://img.shields.io/badge/platform-swift-lightgrey.svg?style=flat)](https://developer.ibm.com/swift/)

### Table of Contents
* [Summary](#summary)
* [Requirements](#requirements)
* [Project contents](#project-contents)
* [Configuration](#configuration)
* [Run](#run)
* [License](#license)
* [Generator](#generator)

### Summary
This scaffolded application provides a starting point for creating Swift applications running on [Kitura](https://developer.ibm.com/swift/kitura/).

### Requirements
* [Swift 3](https://swift.org/download/)

### Project contents
This application has been generated with the following capabilities and services:

* [Configuration](#configuration)
* [Static web file serving](#static-web-file-serving)
* [OpenAPI / Swagger endpoint](#openapi--swagger-endpoint)
* [Example endpoints](#example-endpoints)
* [Embedded metrics dashboard](#embedded-metrics-dashboard)
* [Docker files](#docker-files)
* [CouchDB](#couchdb)
* [Redis](#redis)

#### Static web file serving
This application includes a `public` directory in the root of the project. The contents of this directory will be served as static content using the built-in Kitura [StaticFileServer module](https://github.com/IBM-Swift/Kitura/wiki/Serving-Static-Content).

This content is hosted on `/`. For example, if you want to view `public/myfile.html` and the application is hosted at https://localhost:8080, go to https://localhost:8080/myfile.html.
#### OpenAPI / Swagger endpoint
This application hosts an endpoint for serving the OpenAPI Swagger definition for this application. It expects the definition file to be located in `definitions/gyui.yaml`.

The endpoint is hosted on `/swagger/api`. For example, if the application is hosted at https://localhost:8080, go to https://localhost:8080/swagger/api.
#### Example endpoints
This application includes an OpenAPI Swagger definition and routes for a Product example resource. The OpenAPI Swagger definition is located in the `definitions/gyui.yaml` directory.

The specification of this interface is made available through an embedded Swagger UI hosted on `/explorer`. For example, if the application is hosted at https://localhost:8080, go to https://localhost:8080/explorer.

The Swagger UI will document the paths and http methods that are supported by the application.
#### Embedded metrics dashboard
This application uses the [SwiftMetrics package](https://github.com/RuntimeTools/SwiftMetrics) to gather application and system metrics.

These metrics can be viewed in an embedded dashboard on `/swiftmetrics-dash`. The dashboard displays various system and application metrics, including CPU, memory usage, HTTP response metrics and more.
#### Docker files
The application includes the following files for Docker support:
* `.dockerignore`
* `Dockerfile`
* `Dockerfile-tools`

The `.dockerignore` file contains the files/directories that should not be included in the built docker image. By default this file contains the `Dockerfile` and `Dockerfile-tools`. It can be modified as required.

The `Dockerfile` defines the specification of the default docker image for running the application. This image can be used to run the application.

The `Dockerfile-tools` is a docker specification file similar to the `Dockerfile`, except it includes the tools required for compiling the application. This image can be used to compile the application.

Details on how to build the docker images, compile and run the application within the docker image can be found in the [Run section](#run) below.
#### CouchDB
This application uses the [Kitura-CouchDB package](https://github.com/IBM-Swift/Kitura-CouchDB), which allows Kitura applications to interact with a CouchDB database.

CouchDB speaks JSON natively and supports binary for all your data storage needs.

Boilerplate code for creating a client object for the Kitura-CouchDB API is included inside `Sources/Application/Application.swift` as an `internal` variable available for use anywhere in the `Application` module.

The connection details for this client are loaded by the [configuration](#configuration) code and are passed to the Kitura-CouchDB client in the boilerplate code.
#### Redis
This application uses the [Kitura-redis](http://ibm-swift.github.io/Kitura-redis/) library, which allows Kitura applications to interact with a Redis database.

Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache and message broker. It supports a cracking array of data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs and geospatial indexes with radius queries.

Boilerplate code for creating a client object for the Kitura-redis API is included inside `Sources/Application/Application.swift` as an `internal` variable available for use anywhere in the `Application` module.

 The connection details for this client are loaded by the [configuration](#configuration) code and stored in a `struct` for easy access when creating connections to Redis.

### Configuration
Your application configuration information is stored in the `config.json` in the project root directory. This file is in the `.gitignore` to prevent sensitive information from being stored in git.

The connection information for any configured services, such as username, password and hostname, is stored in this file.

The application uses the [Configuration package](https://github.com/IBM-Swift/Configuration) to read the connection and configuration information from this file.

### Run
To build and run the application:
1. `swift build`
1. `.build/debug/gyui`

**NOTE**: On macOS you will need to add options to the `swift build` command: `swift build -Xlinker -lc++`

#### Docker
To build the two docker images, run the following commands from the root directory of the project:
* `docker build -t myapp-run .`
* `docker build -t myapp-build -f Dockerfile-tools .`
You may customize the names of these images by specifying a different value after the `-t` option.

To compile the application using the tools docker image, run:
* `docker run -v $PWD:/root/project -w /root/project myapp-build /root/utils/tools-utils.sh build release`

To run the application:
* `docker run -it -p 8080:8080 -v $PWD:/root/project -w /root/project myapp-run sh -c .build/release/gyui`


### License
All generated content is available for use and modification under the permissive MIT License (see `LICENSE` file), with the exception of SwaggerUI which is licensed under an Apache-2.0 license (see `NOTICES.txt` file).

### Generator
This project was generated with [generator-swiftserver](https://github.com/IBM-Swift/generator-swiftserver) v1.0.4.
