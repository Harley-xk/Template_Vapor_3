//
//  MySQLJsonType.swift
//  App
//
//  Created by Harley-xk on 2019/5/26.
//

import Foundation
import Vapor
import FluentMySQL

/// 符合该协议的类型保存到数据库时会以 JSON 形式保存为单个字段
protocol MySQLJsonType: MySQLType {}

extension MySQLJsonType {
    static var mysqlDataType: MySQLDataType {
        return .json
    }
}

extension MySQLJsonType where Self: Codable {
    func convertToMySQLData() -> MySQLData {
        return MySQLData(json: self)
    }
    
    static func convertFromMySQLData(_ mysqlData: MySQLData) throws -> Self {
        return try mysqlData.json(Self.self)!
    }
}
