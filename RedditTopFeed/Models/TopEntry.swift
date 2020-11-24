//
//  TopEntry.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

struct TopEntry: Decodable {
    
    struct Data: Decodable {
        struct Preview: Decodable {
            let images: [Image]?
        }
        
        let title: String
        let author: String
        let created: Date
        let numComments: Int
        let thumbnail: URL?
        let preview: Preview
    }
    
    let data: Data
}

// MARK: - Formatters

extension TopEntry.Data {
    
    private static let numCommentsLocalizationKey: String = "top_feed_comments"
    
    private static let dateTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    var createdStringFormatted: String {
        return Self.dateTimeFormatter.localizedString(for: created, relativeTo: Date())
    }
    
    var numCommentsFormatted: String {
        let format = NSLocalizedString(Self.numCommentsLocalizationKey, comment: "format to be found in Localizable.stringsdict")
        return String.localizedStringWithFormat(format, numComments)
    }
    
}

// MARK: - Mock

extension TopEntry.Data {
    
    static func mock() -> TopEntry.Data {
        return TopEntry.Data(
            title: String.random(length: UInt.random(in: 15..<150)),
            author: String.random(length: 10),
            created: Date().addingTimeInterval(TimeInterval(-Int.random(in: 60..<3600))),
            numComments: Int.random(in: 0..<1000),
            thumbnail: Bool.random() ? nil : URL(staticString: "https://b.thumbs.redditmedia.com/muRm2Kx-5DaVCWVTuoI5D6SV_Sa46UCMchCn3Fk6QuE.jpg"),
            preview: Preview(images: [Image.mock()])
        )
    }
    
}
