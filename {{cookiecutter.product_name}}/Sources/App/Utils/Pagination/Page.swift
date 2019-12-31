//
//  Page.swift
//  Pagination
//
//  Created by Harley-xk on 2019/12/31.
//

import Foundation
import Fluent
import Vapor

/// A page with information used to create pagination output.
public struct QueryPage<M> {

    // MARK: - Properties

    /// The current page number.
    public let page: Int

    /// The underlying data that is paginated.
    public let data: [M]

    /// The page size, also known as `per`.
    public let size: Int

    /// The total amount of data entities in the database.
    public let total: Int

    // MARK: - Lifecycle

    // The query used must already be filtered for
    // pagination and ready for `.all()` call
    public init(page: Int, data: [M], size: Int, total: Int) throws {
        guard page >= 0 else {
            throw Pagination.PaginationParamError(page: page)
        }
        self.page = page
        self.data = data
        self.size = size
        self.total = total
    }
}

public protocol ContentConvertible {
    associatedtype ContentType: Content
    func makeContent() -> ContentType
}

extension Model where Self: Content {
    typealias ContentType = Self
    func makeContent() -> Self {
        return self
    }
}

extension QueryPage where M: ContentConvertible {
    public func makeContent() -> Page<M.ContentType> {
        let contentDatas = data.compactMap{$0.makeContent()}
        return Page(page: page, data: contentDatas, size: size, total: total)
    }
}

public struct Page<M: Content>: Content {
    // MARK: - Properties
    
    /// The current page number.
    public let page: Int
    
    /// The underlying data that is paginated.
    public let data: [M]
    
    /// The page size, also known as `per`.
    public let size: Int
    
    /// The total amount of data entities in the database.
    public let total: Int
}
