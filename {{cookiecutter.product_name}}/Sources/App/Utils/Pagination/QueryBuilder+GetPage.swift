//
//  QueryBuilder+GetPage.swift
//  Pagination
//
//  Created by Harley-xk on 2019/12/31.
//

import Fluent
import Vapor

extension QueryBuilder {

    public func getPage(on request: Request) throws -> Future<QueryPage<Result>> {
        let param = try request.getPageParam()
        return try getPage(page: param.page ?? 0, size: param.size ?? Pagination.Value.defaultSize)
    }
    
    /// Get a `Page` with a transformation closure.
    /// If you don't need the advanced transform closure, use the method without the closure.
    ///
    /// - Parameters:
    ///   - page: The current page that is being fetched.
    ///   - size: Items per page.
    /// - Returns: A page based on the transformation output.
    public func getPage(page: Int, size: Int = Pagination.Value.defaultSize) throws -> Future<QueryPage<Result>> {

        // Make sure the current page is greater than 0
        guard page >= 0 else {
            throw Pagination.PaginationParamError(page: page)
        }

        // Per-page also must be greater than zero
        guard size > 0 else {
            throw Pagination.PaginationParamError(size: size)
        }

        // Return a full count
        return self.count().flatMap { total in
            // Limit the query to the desired page
            let lowerBound = page * size
            return self.range(lower: lowerBound, upper: lowerBound + size - 1).all().map({ (results) -> QueryPage<Result> in
                return try QueryPage(page: page, data: results, size: size, total: total)
            })
        }
    }
}

extension QueryBuilder where Result: ContentConvertible {
    public func paginate(on request: Request) throws -> Future<Page<Result.ContentType>> {
        let param = try request.getPageParam()
        return try getPage(page: param.page ?? 0, size: param.size ?? Pagination.Value.defaultSize).map({ (queryPage) -> Page<Result.ContentType> in
            return queryPage.makeContent()
        })
    }
}
