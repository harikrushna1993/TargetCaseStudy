//
//  NetworkConstant.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

struct NetworkConstant {
    static let baseUrl = "https://api.target.com/mobile_case_study_deals/v1/"
}

enum CustomError: Error {
    case unknownError
    case noResult
    
    var message: String {
        switch self {
        case .unknownError:
            return "unknown error"
            case .noResult:
            return "Data is not available"
        }
    }
}

extension CustomError: LocalizedError {
    var errorDescription: String? { return self.message }
    var failureReason: String? { return self.message }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }
}
