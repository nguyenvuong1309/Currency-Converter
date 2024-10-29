// Model/ExchangeRatesResponse.swift
import Foundation

struct ExchangeRatesResponse: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}
