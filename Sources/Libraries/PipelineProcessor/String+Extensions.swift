//
//  String+Extensions.swift
//  PipelineProcessor
//
//  Created by Joe Blau on 1/2/19.
//

import Foundation

extension String {    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: self)
    }
}
