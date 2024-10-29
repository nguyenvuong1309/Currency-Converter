// ContentView.swift

import SwiftUI

struct CurrencyConverter: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    @EnvironmentObject var languageSettings: SettingsViewModel
    
    @State private var isFromCurrencyPickerPresented = false
    @State private var isToCurrencyPickerPresented = false
    
    var body: some View {
        baseView()
    }

    
    @ViewBuilder
    private func baseView() -> some View {
        switch viewModel.states {
        case .finished:
            NavigationView {
            Form {
                // Input Amount Section
                Section(header: Text("enter_amount".localised(using: languageSettings.selectedLanguage))) {
                    TextField("amount".localised(using: languageSettings.selectedLanguage), text: $viewModel.inputAmount)
                        .keyboardType(.decimalPad)
                }

                // Select Currencies Section
                Section(header: Text("select_currencies".localised(using: languageSettings.selectedLanguage))) {
                    HStack {
                        Text("from".localised(using: languageSettings.selectedLanguage))
                        Spacer()
                        Button(action: {
                            isFromCurrencyPickerPresented = true
                        }) {
                            Text("\(viewModel.currencyFlags[viewModel.fromCurrency] ?? "") \(viewModel.fromCurrency)")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isFromCurrencyPickerPresented) {
                            CurrencyPickerView(selectedCurrency: $viewModel.fromCurrency, currencies: viewModel.currencies, currencyFlags: viewModel.currencyFlags)
                                .environmentObject(languageSettings)
                        }
                    }
                    HStack {
                        Text("to".localised(using: languageSettings.selectedLanguage))
                        Spacer()
                        Button(action: {
                            isToCurrencyPickerPresented = true
                        }) {
                            Text("\(viewModel.currencyFlags[viewModel.toCurrency] ?? "") \(viewModel.toCurrency)")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isToCurrencyPickerPresented) {
                            CurrencyPickerView(selectedCurrency: $viewModel.toCurrency, currencies: viewModel.currencies, currencyFlags: viewModel.currencyFlags)
                                .environmentObject(languageSettings)
                        }
                    }
                }

                // Result Section
                Section(header: Text("result".localised(using: languageSettings.selectedLanguage))) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("\(viewModel.formattedConvertedAmount) \(viewModel.toCurrency)")
                    }
                }

                // Settings Navigation
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Text("settings".localised(using: languageSettings.selectedLanguage))
                    }
                }
            }
            .navigationTitle("currency_convert".localised(using: languageSettings.selectedLanguage))
            .toolbar {
                Button("convert".localised(using: languageSettings.selectedLanguage)) {
                    viewModel.convertCurrency()
                }
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text("error".localised(using: languageSettings.selectedLanguage)),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("close".localised(using: languageSettings.selectedLanguage)))
                )
            }
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        case .loading:
            ProgressView("Loading")
        case .error(error: let error):
            CustomStateView(image: "exclamationmark.transmission",
                            description: "Something get wrong !",
                            tintColor: .red)
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error Message"),
                          message: Text(error),
                          dismissButton: Alert.Button.default(
                            Text("Ok"), action: {
                                viewModel.changeStateToEmpty()
                            }
                          ))
                }
        case .ready:
            ProgressView()
                .onAppear {
                    viewModel.serviceInitialize()
                }
        case .empty:
            CustomStateView(image: "newspaper",
                            description: "There is no data :(",
                            tintColor: .indigo)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverter()
            .environmentObject(SettingsViewModel())
    }
}
