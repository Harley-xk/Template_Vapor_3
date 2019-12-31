//
//  AppConfig.swift
//  App
//
//  Created by Harley-xk on 2019/3/4.
//

import Foundation
import Vapor
import MySQL

struct AppConfig: Codable {
    
    /// 全局配置选项
    static var global: AppConfig!
    
    var host: Host
    
    var database: Database
    
    static func initialize(for env: Environment) throws {
        let logger = TimedLogger()
        logger.log(.info, message: ("Launching with env: " + env.name + "..."))
        let path = DirectoryConfig.detect().workDir + "config-" + env.name + ".json"
        
        let configData = try Data(contentsOf: URL(fileURLWithPath: path))
        AppConfig.global = try JSONDecoder().decode(AppConfig.self, from: configData)
        logger.log(.info, message: "Launching with config file: \(path)")
    }
    
    /// 服务器配置
    struct Host: Codable {
        var name: String
        var port: Int
    }
    
    /// 数据库配置
    struct Database: Codable {
        var name: String
        var host: String
        var port: Int
        var username: String
        var password: String
    }
}
