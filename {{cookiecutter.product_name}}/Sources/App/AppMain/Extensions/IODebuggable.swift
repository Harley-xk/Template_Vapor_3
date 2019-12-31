//
//  IODebuggable.swift
//  App
//
//  Created by Harley-xk on 2019/5/30.
//

import Foundation
import Vapor

extension IOError: Debuggable {
    public var identifier: String {
        return "\(errnoCode)"
    }
    
    public var reason: String {
        return self.localizedDescription
    }
}
