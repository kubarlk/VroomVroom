import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "cars_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "cars_password",
        database: Environment.get("DATABASE_NAME") ?? "cars_database"
    ), as: .psql)

    app.migrations.add(CreateUser())
    app.migrations.add(CreateCar())
    app.migrations.add(CreateCarLogo())
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
