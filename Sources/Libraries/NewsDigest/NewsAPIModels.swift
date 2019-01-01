//
//  TopHeadlines.swift
//  NewsDigest
//
//  Created by Joe Blau on 1/1/19.
//

import Foundation

public struct Articles: Codable {
    public var status: String
    public var totalResults: Int?
    public var articles: [Article]?
    public var code: String?
    public var message: String?
}

public struct Article: Codable {
    public var source: Source
    public var author: String?
    public var title: String?
    public var description: String?
    public var url: String
    public var urlToImage: String?
    public var publishedAt: String
    public var content: String?
}

public struct Sources: Codable {
    public var status: String
    public var sources: [Source]?
    public var code: String?
    public var message: String?
}

public struct Source: Codable {
    public var id: String?
    public var name: String
    public var descriptoin: String?
    public var url: String?
    public var category: String?
    public var language: String?
    public var country: String?
}
