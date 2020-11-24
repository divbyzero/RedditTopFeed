//
//  TopEntry.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

struct TopEntry: Decodable {
    struct Data: Decodable {
        let title: String
        let author: String
        let created: Date
        let numComments: Int
        let thumbnail: URL?
        let url: String
    }
}

// MARK: - Formatters

extension TopEntry.Data {
    
    private static let numCommentsLocalizationKey: StaticString = "top_feed_comments"
    
    private static let dateTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    var createdStringFormatted: String {
        return Self.dateTimeFormatter.localizedString(for: created, relativeTo: Date())
    }
    
    var numCommentsFormatted: String {
        let format = NSLocalizedString("numCommentsLocalizationKey", comment: "string format to be found in Localizable.stringsdict")
        return String.localizedStringWithFormat(format, numComments)
    }
    
}

// MARK: - Mock

extension TopEntry.Data {
    
    static func mock() -> TopEntry.Data {
        return TopEntry.Data(
            title: String.random(length: 10),
            author: String.random(length: 10), created: Date(),
            numComments: Int.random(in: 0..<1000),
            thumbnail: Bool.random() ? nil : URL(staticString: "https://b.thumbs.redditmedia.com/muRm2Kx-5DaVCWVTuoI5D6SV_ Sa46UCMchCn3Fk6QuE.jpg"),
            url: "https://google.com")
    }
    
}
