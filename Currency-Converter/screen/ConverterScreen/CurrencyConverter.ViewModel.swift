// CurrencyViewModel.swift

import Foundation
import SwiftUI
import Combine

class CurrencyConverterViewModel:  BaseViewModel<CurrencyConverterStates> {
    // Published properties to update the view
    @Published var inputAmount: String = ""
    @Published var fromCurrency: String = "EUR"
    @Published var toCurrency: String = "USD"
    @Published var convertedAmount: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("selectedLanguage") var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    
    @Published var exchangeRates: [String: Double] = [:]

    var showingAlert: Bool = false
    
    let currencies = ["EUR", "USD", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "HKD", "INR", "SGD", "BTC"]
    
    let currencyFlags: [String: String] = [
        "EUR": "🇪🇺", "USD": "🇺🇸", "JPY": "🇯🇵", "GBP": "🇬🇧", "AUD": "🇦🇺",
        "CAD": "🇨🇦", "CHF": "🇨🇭", "CNY": "🇨🇳", "HKD": "🇭🇰", "INR": "🇮🇳",
        "SGD": "🇸🇬", "BTC": "🟡",
        "VND": "🇻🇳",
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
//    init() {
//        // Optionally, fetch exchange rates on initialization
//        // fetchExchangeRates()
//    }

    func serviceInitialize() {
        fetchExchangeRates { [weak self] success in
            guard let self = self else { return }
            self.isLoading = false
            self.changeState(.finished)
            if success {
                if let fromRate = self.exchangeRates[self.fromCurrency], let toRate = self.exchangeRates[self.toCurrency] {
                } else {
                    self.errorMessage = NSLocalizedString("cannot_fetch_exchange_rates", comment: "")
                    self.showError = true
                }
            } else {
                self.errorMessage = NSLocalizedString("cannot_fetch_exchange_rates", comment: "")
                self.showError = true
            }
        }
    }

    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    // Function to perform currency conversion
    func convertCurrency() {
        guard let amount = Double(inputAmount), amount > 0 else {
            errorMessage = NSLocalizedString("invalid_amount", comment: "")
            showError = true
            return
        }
        isLoading = true
        fetchExchangeRates { [weak self] success in
            guard let self = self else { return }
            self.isLoading = false
            if success {
                if let fromRate = self.exchangeRates[self.fromCurrency], let toRate = self.exchangeRates[self.toCurrency] {
                    let baseAmount = amount / fromRate
                    self.convertedAmount = baseAmount * toRate
                } else {
                    self.errorMessage = NSLocalizedString("cannot_fetch_exchange_rates", comment: "")
                    self.showError = true
                }
            } else {
                self.errorMessage = NSLocalizedString("cannot_fetch_exchange_rates", comment: "")
                self.showError = true
            }
        }
    }
    
    // Function to fetch exchange rates from the API
    func fetchExchangeRates(completion: @escaping (Bool) -> Void) {
        // changeState(.loading)
        let urlString = "https://api.exchangeratesapi.io/v1/latest?access_key=f36d7950db4e3ded0670571772b404ed-"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> ExchangeRatesResponse in
                let decoder = JSONDecoder()
                return try decoder.decode(ExchangeRatesResponse.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { completionStatus in
                switch completionStatus {
                case .finished:
                    self.changeState(.finished)
                    break
                case .failure(let error):
                    self.showingAlert.toggle()
                    print("Network or decoding error: \(error.localizedDescription)")
                    completion(false)
                }
            } receiveValue: { [weak self] exchangeData in
                guard let self = self else { return }
                self.exchangeRates = exchangeData.rates
                self.exchangeRates[exchangeData.base] = 1.0
                completion(true)
            }
            .store(in: &cancellables)
    }
    
    // Helper to format the converted amount
    var formattedConvertedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."

        if let formattedString = formatter.string(from: NSNumber(value: convertedAmount)) {
            return formattedString
        } else {
            return String(format: "%.2f", convertedAmount)
        }
    }
}
