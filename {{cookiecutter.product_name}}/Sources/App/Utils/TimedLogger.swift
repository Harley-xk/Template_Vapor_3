//
//  TimedLogger.swift
//  App
//
//  Created by Harley-xk on 2019/2/21.
//

import Vapor

final class TimedLogger: Logger, Service {
    func log(_ string: String, at level: LogLevel, file: String, function: String, line: UInt, column: UInt) {
        Swift.print("[\(Date().string())] [ \(level) ] \(string)")
    }
    
    func log(_ level: LogLevel, message: String) {
        log(message, at: level, file: "", function: "", line: 0, column: 0)
    }
    
}
