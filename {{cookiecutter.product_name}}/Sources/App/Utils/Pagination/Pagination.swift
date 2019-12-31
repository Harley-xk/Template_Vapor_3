//
//  Pagination.swift
//  Pagination
//
//  Created by Harley-xk on 2019/12/31.
//

import Foundation
import Vapor

public struct Pagination {
    
    public struct Key {
        public static var defaultPage = "page"
        public static var defaultSize = "size"
    }
    
    public struct Value {
        public static var defaultSize = 10
    }
    
    public struct PageParam: Content {
        var size: Int?
        var page: Int?
    }
    
    public struct PaginationParamError: AbortError {
        public var status: HTTPResponseStatus
        public var reason: String
        public var identifier: String
        
        init(page: Int) {
            self.status = .badRequest
            self.reason = "Invalid page number: \(page)"
            self.identifier = "InvalidPageNumberError"
        }
        
        init(size: Int) {
            self.status = .badRequest
            self.reason = "Invalid page size: \(size)"
            self.identifier = "InvalidPageSizeError"
        }
    }
}

public extension Request {
    func getPageParam() throws -> Pagination.PageParam {
        let param = try query.decode(Pagination.PageParam.self)
        return param
    }
}
