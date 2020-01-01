import Vapor
import FluentMySQL
import Leaf
import Authentication

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    /// 根据环境加载服务器配置文件
    try AppConfig.initialize(for: env)
    
    /// configuer server ip
    let serverConfig = NIOServerConfig.default(hostname: AppConfig.global.host.name,
                                               port: AppConfig.global.host.port,
                                               maxBodySize: 100_000_000,
                                               supportCompression: false)
    services.register(serverConfig)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    let middlewares = MiddlewareConfig()
    services.register(ErrorMiddleware.self)
    services.register(FileMiddleware.self)
    services.register(middlewares)

    /// Register providers first
    try services.register(FluentMySQLProvider())
    /// Configure a SQLite database
    let mysql = MySQLDatabase(config: AppConfig.global)
    /// Register the configured MySQL database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    // Configure migrations
    services.register(MigrationConfig.initialize())
    
    // 注册页面渲染器
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
    
    /// 用户验证器
    try services.register(AuthenticationProvider())
    
    /// Create default content config
    var contentConfig = ContentConfig.default()
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970
    contentConfig.use(encoder: encoder, for: .json)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    contentConfig.use(decoder: decoder, for: .json)
    services.register(contentConfig)
}
