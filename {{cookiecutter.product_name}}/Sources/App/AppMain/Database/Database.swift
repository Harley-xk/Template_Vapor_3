//
//  Migrations.swift
//  App
//
//  Created by Harley-xk on 2019/5/23.
//

import Foundation
import Vapor
import FluentMySQL

extension MySQLDatabase {
    convenience init(config: AppConfig) {
        let databaseConfig = MySQLDatabaseConfig(hostname: config.database.host,
                                                 port: config.database.port,
                                                 username: config.database.username,
                                                 password: config.database.password,
                                                 database: config.database.name)
        self.init(config: databaseConfig)
    }
}

extension MigrationConfig {
    
    static func initialize() -> MigrationConfig {
        
        var migrations = MigrationConfig()
        // migrations.add(model: User.self, database: .mysql)
        // migrations.add(model: Token.self, database: .mysql)

        return migrations
    }

}

