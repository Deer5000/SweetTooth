//
//  ErrorCases.swift
//  SweetToothListPracticeCall
//
//  Created by Khidr Brinkley on 10/11/24.
//

import Foundation

import Foundation

enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    
    var errorDescription: String {
        switch self {
        case .invalidUrl:
            "invalid url"
        case .invalidResponse:
            "invalid response"
        case .invalidData:
            "invalid Data"
        }
    }
}
