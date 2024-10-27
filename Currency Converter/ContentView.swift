//
//  ContentView.swift
//  Currency Converter
//
//  Created by ducvuong on 27/10/24.
//

import SwiftUI

struct ExchangeRatesResponse: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
}

struct ContentView: View {
    @AppStorage("selectedLanguage") var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @EnvironmentObject var languageSettings: LanguageSettings
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State private var inputAmount = ""
    @State private var fromCurrency = "EUR"
    @State private var toCurrency = "USD"
    @State private var convertedAmount: Double = 0.0
    @State private var exchangeRates: [String: Double] = [:]
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isFromCurrencyPickerPresented = false
    @State private var isToCurrencyPickerPresented = false

    let currencies = ["EUR", "USD", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "HKD", "INR", "SGD", "BTC"]
    
    let currencyFlags: [String: String] = [
        "EUR": "🇪🇺", "USD": "🇺🇸", "JPY": "🇯🇵", "GBP": "🇬🇧", "AUD": "🇦🇺",
        "CAD": "🇨🇦", "CHF": "🇨🇭", "CNY": "🇨🇳", "HKD": "🇭🇰", "INR": "🇮🇳",
        "SGD": "🇸🇬", "BTC": "🟡",
        "VND": "🇻🇳",
    ]
    
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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("enter_amount".localised(using: languageSettings.selectedLanguage))) {
                    TextField("amount".localised(using: languageSettings.selectedLanguage), text: $inputAmount)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("select_currencies".localised(using: languageSettings.selectedLanguage))) {
                    HStack {
                        Text("from".localised(using: languageSettings.selectedLanguage))
                        Spacer()
                        Button(action: {
                            isFromCurrencyPickerPresented = true
                        }) {
                            Text("\(currencyFlags[fromCurrency] ?? "") \(fromCurrency)")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isFromCurrencyPickerPresented) {
                            CurrencyPickerView(selectedCurrency: $fromCurrency, currencies: currencies, currencyFlags: currencyFlags)
                                .environmentObject(languageSettings)
                        }
                    }
                    HStack {
                        Text("to".localised(using: languageSettings.selectedLanguage))
                        Spacer()
                        Button(action: {
                            isToCurrencyPickerPresented = true
                        }) {
                            Text("\(currencyFlags[toCurrency] ?? "") \(toCurrency)")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isToCurrencyPickerPresented) {
                            CurrencyPickerView(selectedCurrency: $toCurrency, currencies: currencies, currencyFlags: currencyFlags)
                                .environmentObject(languageSettings)
                        }
                    }
                }

                Section(header: Text("result".localised(using: languageSettings.selectedLanguage))) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("\(formattedConvertedAmount) \(toCurrency)")
                    }
                }

                Section {
                    NavigationLink(destination: SettingsView()) {
                        Text("settings".localised(using: languageSettings.selectedLanguage))
                    }
                }
            }
            .navigationTitle("currency_convert".localised(using: languageSettings.selectedLanguage))
            .toolbar {
                Button("convert".localised(using: languageSettings.selectedLanguage)) {
                    convertCurrency()
                }
            }
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("error".localised(using: languageSettings.selectedLanguage)),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("close".localised(using: languageSettings.selectedLanguage)))
                )
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    func convertCurrency() {
        guard let amount = Double(inputAmount), amount > 0 else {
            errorMessage = "invalid_amount".localised(using: languageSettings.selectedLanguage)
            showError = true
            return
        }
        isLoading = true
        fetchExchangeRates { success in
            isLoading = false
            if success {
                if let fromRate = exchangeRates[fromCurrency], let toRate = exchangeRates[toCurrency] {
                    let baseAmount = amount / fromRate
                    convertedAmount = baseAmount * toRate
                } else {
                    errorMessage = "cannot_fetch_rates".localised(using: languageSettings.selectedLanguage)
                    showError = true
                }
            } else {
                errorMessage = "cannot_fetch_rates".localised(using: languageSettings.selectedLanguage)
                showError = true
            }
        }
    }
    
    func fetchExchangeRates(completion: @escaping (Bool) -> Void) {
        let urlString = "https://api.exchangeratesapi.io/v1/latest?access_key=16d0d19b8e54a36da18e17af6b13c396"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let exchangeData = try decoder.decode(ExchangeRatesResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.exchangeRates = exchangeData.rates
                        self.exchangeRates[exchangeData.base] = 1.0
                        completion(true)
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("JSON decoding error: \(error.localizedDescription)")
                        completion(false)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                    completion(false)
                }
            }
        })
        task.resume()
    }
}

struct CurrencyPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var languageSettings: LanguageSettings
    @Binding var selectedCurrency: String
    @State private var searchText = ""
    
    let currencies: [String]
    let currencyFlags: [String: String]
    
    var filteredCurrencies: [String] {
        if searchText.isEmpty {
            return currencies
        } else {
            return currencies.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCurrencies, id: \.self) { currency in
                    Button(action: {
                        selectedCurrency = currency
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("\(currencyFlags[currency] ?? "") \(currency)")
                            if currency == selectedCurrency {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: NSLocalizedString("select_currencies", comment: ""))
            .navigationTitle(NSLocalizedString("select_currencies", comment: ""))
            .navigationBarItems(trailing: Button(NSLocalizedString("close", comment: "")) {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LanguageSettings())
    }
}
