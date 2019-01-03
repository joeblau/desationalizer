//
//  HugoModels.swift
//  PipelineProcessor
//
//  Created by Joe Blau on 1/3/19.
//

import Foundation

public struct DesationalPost {
    public init(source: String,
                date: String,
                title: String,
                author: String,
                content: String,
                url: String,
                percent: String) {
        self.source = source
        self.date = date
        self.title = title
        self.author = author
        self.content = content
        self.url = url
        self.percent = percent
    }
    public let source: String
    public let date: String
    public let title: String
    public let author: String
    public let content: String
    public let url: String
    public let percent: String
}
