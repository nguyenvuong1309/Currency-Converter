//
//  ServiceModel.swift
//  Currency Converter
//
//  Created by ducvuong on 28/10/24.
//

import Foundation

// MARK: - ServiceModels
struct ServiceModel: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

// MARK: - Article Extension
extension Article: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
}
