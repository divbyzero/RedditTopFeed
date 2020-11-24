//
//  APIError.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

enum APIError: Error {
    case invalidRequestData
    case somethingWentWrong
    case emptyData
}

// MARK: - Helpers

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidRequestData:
            return "Invalid request data"
        case .somethingWentWrong:
            return "Oops! Something Went Wrong."
        case .emptyData:
            return "Empty Data"
        }
    }
}
