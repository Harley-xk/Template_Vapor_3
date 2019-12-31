//
//  ModelUtil.swift
//  App
//
//  Created by Harley.xk on 2018/5/25.
//

import Foundation
import Vapor
import Random
import Crypto

/// 加密用户密码
public func hashedPassword(_ pass: String) throws -> String {
    return try  BCrypt.hash(pass)
}

/// 生成指定位数的验证码
///
/// - Parameter length: 验证码长度，第一位保证不为 0
public func GenerateCaptcha(length: Int = 6) -> String {
    var captcha = ""
    for index in 0 ..< length {
        let random = Int.random(in: (index == 0 ? 1 : 0) ... 9)
        captcha.append("\(random)")
    }
    return captcha
}

extension String {
    public static func random(bytes: Int = 6) -> String {
        return OSRandom().generateData(count: bytes).base64URLEncodedString()
    }
    
    // convert string to int
    // returns 0 if failed
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    // convert string to double
    // returns 0 if failed
    var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    // convert string to float
    // returns 0 if failed
    var floatValue: Float {
        return Float(self) ?? 0
    }
}

extension Date {
    func string(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
